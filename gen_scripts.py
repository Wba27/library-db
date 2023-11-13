from tables import tables, Attribute
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


def sql_column_from_attribute(a: Attribute):
    type_text = python_type_to_sql_type_text(a.data_type, a.data_length)
    add_text = 'NULL' if a.nullable else 'NOT NULL'
    if a.primary_key:
        add_text += ' PRIMARY KEY'
    return f'{a.name} {type_text} {add_text}'


def constraints_text(table, attributes: list[Attribute]):
    constraints_text = ''
    for a in attributes:
        if '.' in a.foreign_key:
            f_table, f_col = a.foreign_key.split('.')
        else:
            f_table = a.foreign_key
            f_col = a.name
        constraints_text += f'ALTER TABLE {table}\n'
        constraints_text += f'ADD CONSTRAINT fk_{table}_{a.name}\n'
        constraints_text += f'\tFOREIGN KEY ({a.name})\n'
        constraints_text += f'\tREFERENCES {f_table}({f_col});\n\n'
    return constraints_text


def create_tables(f: TextIOWrapper):
    f.write('-- CREATE TABLES --\n')
    for table, attributes in tables.items():
        f.write(f'CREATE TABLE {table}(\n')
        for a in attributes:
            f.write(f'\t{sql_column_from_attribute(a)}')
            f.write(',\n' if a != attributes[-1] else '\n')
        f.write(');\n\n')
        if (foreign_keys := [a for a in attributes if a.foreign_key]):
            f.write(constraints_text(table, foreign_keys))


def main():
    with open("library-db.txt", "w") as f:
        create_tables(f)
    # for table, attributes in tables.items():
    #     print(table)
    #     for attr in attributes:
    #         print(attr)


if __name__ == '__main__':
    main()
