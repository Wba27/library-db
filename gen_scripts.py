from tables import tables, Attribute
from gen_test_data import get_random_human, get_random_resource, weighted_random
from io import TextIOWrapper
from datetime import datetime, date
from decimal import Decimal


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


def create_tables(f: TextIOWrapper):
    f.write('-- 1: CREATE TABLES --\n')
    for table, attributes in tables.items():
        f.write(f'CREATE TABLE {table}(\n')
        for a in attributes:
            f.write(f'\t{sql_column_from_attribute(a)}')
            f.write(',\n' if a != attributes[-1] else '\n')
        f.write(');\n\n')
        if (foreign_keys := [a for a in attributes if a.foreign_key]):
            f.write(foreign_keys_text(table, foreign_keys))
        if (unique_keys := [a for a in attributes if a.unique]):
            f.write(unique_keys_text(table, unique_keys))


def required_attribute_names(attributes: list[Attribute]):
    return [a.name for a in attributes if a.default is None and not a.nullable]


def stringify_value(v: any):
    if type(v) == str:
        return f"'{v}'"
    if type(v) == date:
        return python_date_to_sql_date(v)
    return str(v)


def python_date_to_sql_date(d: date):
    return f"To_Date('{d.year}/{d.month}/{d.day}', 'yyyy/mm/dd')"


def insert_into_table(table_name: str, table_cols: list[str], *data):
    cols_str = ', '.join(table_cols)
    values_str = ', '.join(stringify_value(i) for i in data)
    insert_text = f'INSERT INTO {table_name}\n'
    insert_text += f'({cols_str})\n'
    insert_text += f'VALUES ({values_str});\n\n'
    return insert_text


def insert_members_text():
    undergrads = [get_random_human('member', 1998, 2006) for _ in range(30)]
    postgrads = [get_random_human('member', 1989, 1999) for _ in range(30)]
    staff = [get_random_human('member', 1968, 1995) for _ in range(30)]
    insert_members_text = ''
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


def insert_data(f: TextIOWrapper):
    f.write('-- 2: INSERT DATA --\n')
    insert_text = insert_members_text()
    f.write(insert_text)
    authors = [get_random_human('author', 1940, 1990) for _ in range(20)]
    for author in authors:
        resources = [get_random_resource() for i in weighted_random(1, 5, 2)]


def main():
    with open("library-db.txt", "w") as f:
        f.write('-- AUTO GEN SQL SCRIPT --\n\n')
        create_tables(f)
        insert_data(f)


if __name__ == '__main__':
    main()
