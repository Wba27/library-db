from tables import tables, Attribute, CHECK_TYPE
from gen_test_data import Human, get_random_human, subjects, get_random_resource, \
    weighted_random, get_copies_of_resource
from io import TextIOWrapper
from typing import Literal
import random
from datetime import datetime, date
from decimal import Decimal

PATH = 'sql_scripts/'


def write_files(f_list: tuple[TextIOWrapper], text: str, msg: str = None):
    if msg:
        print(msg)
    for f in f_list:
        f.write(text)


def python_type_to_sql_type_text(t: type, l: int):
    if t is int:
        return 'INTEGER'
    elif t is str:
        if l == 1:
            return 'CHAR(1)'
        else:
            return f'VARCHAR({l})'
    elif t is bool:
        return 'CHAR(1)'
    elif t is datetime:
        return 'TIMESTAMP'
    elif t is date:
        return 'DATE'
    elif t is Decimal:
        return 'DECIMAL'
    else:
        raise AttributeError(f"Unsupported data type {t}")
    

def sql_default(d):
    if type(d) == bool:
        return "'Y'" if d else "'N'"
    return d


def sql_column_from_attribute(a: Attribute):
    type_text = python_type_to_sql_type_text(a.data_type, a.data_length)
    if a.default is not None:
        add_text = f'DEFAULT {sql_default(a.default)}'
    else:
        add_text = 'NULL' if a.nullable else 'NOT NULL'
    if a.primary_key:
        add_text += ' PRIMARY KEY'
    return f'{a.name} {type_text} {add_text}'


def foreign_keys_text(table, attributes: list[Attribute]):
    fk_text = ''
    for a in attributes:
        if '.' in a.foreign_key:
            f_table, f_col = a.foreign_key.split('.')
        else:
            f_table = a.foreign_key
            f_col = a.name
        fk_text += f'ALTER TABLE {table}\n'
        fk_text += f'ADD CONSTRAINT fk_{table}_{a.name}\n'
        fk_text += f'\tFOREIGN KEY ({a.name})\n'
        fk_text += f'\tREFERENCES {f_table}({f_col});\n\n'
    return fk_text


def unique_keys_text(table, attributes: list[Attribute]):
    uk_attributes = ', '.join([a.name for a in attributes])
    uk_text = f'ALTER TABLE {table}\n'
    uk_text += f'ADD CONSTRAINT {table}_unique UNIQUE ({uk_attributes});\n\n'
    return uk_text


def check_constraint_text(table, attributes: list[Attribute]):
    checks_to_perform = set(a.check for a in attributes)
    check_text = ''
    for check in checks_to_perform:
        if check.name is CHECK_TYPE.XOR:
            xor_attributes = [a.name for a in attributes if a.check.name is CHECK_TYPE.XOR]
            assert len(xor_attributes) == 2, f'Too many XORS on {table}: {xor_attributes}'
            xor_1, xor_2 = xor_attributes
            check_text += f'ALTER TABLE {table}\n'
            check_text += f'ADD CONSTRAINT {table}_xor\n'
            check_text += f'\tCHECK(({xor_1} IS NULL OR {xor_2} IS NULL)\n'
            check_text += f'\tAND NOT ({xor_1} IS NULL AND {xor_2} IS NULL));\n\n'
        if check.name is CHECK_TYPE.IN:
            in_attributes = [a for a in attributes if a.check.name is CHECK_TYPE.IN]
            assert all(a.check.data is not None for a in in_attributes), \
                f'{table} contains IN check with no possible values'
            for a in in_attributes:
                in_options = ', '.join([f"'{i}'" for i in a.check.data])
                check_text += f'ALTER TABLE {table}\n'
                check_text += f'ADD CONSTRAINT {table}_{a.name}_in\n'
                check_text += f'\tCHECK({a.name} IN ({in_options}));\n\n'
    return check_text


def constrain_booleans_text(table, booleans: list[Attribute]):
    boolean_text = ''
    for b in booleans:
        boolean_text += f'ALTER TABLE {table}\n'
        boolean_text += f'ADD CONSTRAINT {table}_{b.name}_bool\n'
        boolean_text += f"\tCHECK({b.name} IN ('Y', 'N'));\n\n"
    return boolean_text


def create_tables(f: TextIOWrapper):
    with open(f'{PATH}1-create-tables.sql', 'w') as cf:
        write_files((f, cf), '-- 1: CREATE TABLES --\n\n', 'Creating tables...')
        for table, attributes in tables.items():
            write_files((f, cf), f'CREATE TABLE {table}(\n')
            for a in attributes:
                write_files((f, cf), f'\t{sql_column_from_attribute(a)}')
                write_files((f, cf), ',\n' if a != attributes[-1] else '\n')
            write_files((f, cf), ');\n\n')
            if (foreign_keys := [a for a in attributes if a.foreign_key]):
                write_files((f, cf), foreign_keys_text(table, foreign_keys))
            if (unique_keys := [a for a in attributes if a.unique]):
                write_files((f, cf), unique_keys_text(table, unique_keys))
            if (check_constraints := [a for a in attributes if a.check]):
                write_files((f, cf), check_constraint_text(table, check_constraints))
            if (booleans := [a for a in attributes if a.data_type is bool]):
                write_files((f, cf), constrain_booleans_text(table, booleans))
        write_files((f, cf), '-- INSERT MAX LOANS --\n\n')
        write_files((f, cf), insert_into_table(
            'MemberMaxLoans', 
            required_attribute_names(tables['MemberMaxLoans']),
            'S', 
            5
        ))
        write_files((f, cf), insert_into_table(
            'MemberMaxLoans', 
            required_attribute_names(tables['MemberMaxLoans']),
            'T', 
            10
        ))


def required_attribute_names(attributes: list[Attribute]):
    return [a.name for a in attributes if a.default is None and not a.nullable]


def all_attribute_names(attributes: list[Attribute]):
    return [a.name for a in attributes]


def stringify_value(v: any):
    if type(v) == str:
        return f"'{v}'"
    if type(v) == bool:
        return "'Y'" if v else "'N'"
    if type(v) == date:
        return python_date_to_sql_date(v)
    if type(v) == datetime:
        return python_datetime_to_sql_timestamp(v)
    if v is None:
        return 'NULL'
    return str(v)


def python_date_to_sql_date(d: date):
    return f"To_Date('{d.year}/{d.month}/{d.day}', 'yyyy/mm/dd')"


def python_datetime_to_sql_timestamp(d: datetime):
    return f"To_Timestamp('{d.year}/{d.month}/{d.day} {d.hour}:{d.minute}:{d.second}', 'YYYY/MM/DD HH24:MI:SS')"


def insert_into_table(table_name: str, table_cols: list[str], *data):
    cols_str = ', '.join(table_cols)
    values_str = ', '.join(stringify_value(i) for i in data)
    insert_text = f'INSERT INTO {table_name}\n'
    insert_text += f'({cols_str})\n'
    insert_text += f'VALUES ({values_str});\n\n'
    return insert_text


def insert_members_text():
    undergrads = [get_random_human('member', 1998, 2006) for _ in range(scale * 3)]
    postgrads = [get_random_human('member', 1989, 1999) for _ in range(scale * 3)]
    staff = [get_random_human('member', 1968, 1995) for _ in range(scale * 3)]
    insert_members_text = '-- 2: INSERT MEMBERS --\n\n'
    for member in undergrads + postgrads + staff:
        insert_members_text += insert_into_table(
            'Member', 
            required_attribute_names(tables['Member']),
            member.id,
            member.first_name,
            member.last_name,
            member.email,
            member.date_of_birth,
            'T' if member in staff else 'S'
        )
    return insert_members_text


def insert_subjects_text():
    subjects_text = '-- 3: INSERT SUBJECTS --\n\n'
    for e, s in enumerate(subjects.keys()):
        subjects_text += insert_into_table(
            'Subject',
            required_attribute_names(tables['Subject']),
            e,
            s
        )
    return subjects_text


def insert_author_text(authors):
    authors_text = '-- 4: INSERT AUTHORS --\n\n'
    for author in authors:
        authors_text += insert_into_table(
            'Author',
            required_attribute_names(tables['Author']),
            author.id,
            author.first_name,
            author.last_name,
            author.date_of_birth
        )
    return authors_text


def copies_of_resource_text(resource_number: int, resource_type: str):
    copies = get_copies_of_resource(resource_number)
    copies_text = ''
    for copy in copies:
        copies_text += insert_into_table(
            'Copy',
            all_attribute_names(tables['Copy']),
            copy.id,
            resource_number if resource_type == 'B' else None,
            resource_number if resource_type != 'B' else None,
            copy.acquired_timestamp,
            copy.floor_no,
            copy.shelf_no,
            copy.archived
        )
    return copies_text


def insert_resource_text(
        author_type: Literal['academic', 'fiction', 'non-fiction'], 
        authors: list[Human],
        e: int
    ):
    resource_text = f'-- {e}: INSERT RESOURCES, COPIES: {author_type.upper()} --\n\n'
    for author in authors:
        resources = [
            get_random_resource(author_type) for _ in range(weighted_random(1, scale, 2))
        ]
        books = [r for r in resources if r.resource_type == 'B']
        av_media = [r for r in resources if r.resource_type != 'B']
        for b in books:
            for e, edition in enumerate(b.editions):
                resource_text += insert_into_table(
                    'Book',
                    required_attribute_names(tables['Book']),
                    b.id + e,
                    b.title,
                    edition,
                    b.date_published,
                    b.class_no,
                    b.loan_type,
                    b.page_length
                )
                resource_text += copies_of_resource_text(b.id + e, 'B')
                resource_text += insert_into_table(
                    'AuthorResource',
                    all_attribute_names(tables['AuthorResource']),
                    author.id,
                    b.id + e,
                    None
                )
            if author_type == 'academic' and random.randint(0, 1) == 1:
                coauthor = random.choice([a for a in authors if a is not author])
                for e, edition in enumerate(b.editions):
                    resource_text += insert_into_table(
                        'AuthorResource',
                        all_attribute_names(tables['AuthorResource']),
                        coauthor.id,
                        b.id + e,
                        None
                    )
        for av in av_media:
            resource_text += insert_into_table(
                'AVMedia',
                required_attribute_names(tables['AVMedia']),
                av.id,
                av.title,
                'Standard',
                av.date_published,
                av.class_no,
                av.loan_type,
                av.media_length,
                av.resource_type
            )
            resource_text += copies_of_resource_text(av.id, av.resource_type)
            resource_text += insert_into_table(
                'AuthorResource',
                all_attribute_names(tables['AuthorResource']),
                author.id,
                None,
                av.id
            )
    return resource_text


def insert_author_resource_text(zipped_authors):
    for author_type, authors in zipped_authors:
        if author_type == 'academic':
            e = 5
        elif author_type == 'fiction':
            e = 6
        else:
            e = 7
        yield author_type, insert_resource_text(author_type, authors, e)


def insert_data(f: TextIOWrapper):
    f.write('-- INSERT DATA --\n\n')
    with open(f'{PATH}2-insert-members.sql', 'w') as mf:
        write_files((f, mf), insert_members_text(), 'Inserting members...')
    with open(f'{PATH}3-insert-subjects.sql', 'w') as sf:
        write_files((f, sf), insert_subjects_text(), 'Inserting subjects...')
    academic_authors = [get_random_human('author', 1940, 1990) for _ in range(scale)]
    fiction_authors = [get_random_human('author', 1940, 1990) for _ in range(scale)]
    non_fiction_authors = [get_random_human('author', 1940, 1990) for _ in range(scale)]
    authors = academic_authors + fiction_authors + non_fiction_authors
    with open(f'{PATH}4-insert-authors.sql', 'w') as af:
        write_files((f, af), insert_author_text(authors), 'Inserting authors...')
    author_types = ('academic', 'fiction', 'non-fiction')
    zipped_authors = zip(author_types, 
                         (academic_authors, fiction_authors, non_fiction_authors))
    for e, (author_type, author_text) in enumerate(insert_author_resource_text(
        zipped_authors
    ), 5):
        with open(f'{PATH}{e}-insert-resource-{author_type}.sql', 'w') as arf:
            write_files((f, arf), author_text, f'Inserting {author_type} resources...')


def gen_script(_scale: int):
    global scale
    scale = _scale
    with open(f'{PATH}0-all-scripts.sql', 'w') as f:
        f.write('-- AUTO GEN SQL SCRIPT --\n\n')
        create_tables(f)
        insert_data(f)
