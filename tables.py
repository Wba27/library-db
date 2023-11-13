from dataclasses import dataclass
from datetime import datetime, date
from decimal import Decimal


@dataclass
class Attribute:
    name: str
    data_type: type
    data_length: int = None
    primary_key: bool = False
    foreign_key: str = False
    nullable: bool = False
    unique: bool = False
    default: any = None

tables = {
    'LibResource': [
        Attribute('ResourceNumber', int, primary_key=True),
        Attribute('Title', str, data_length=255, unique=True),
        Attribute('Edition', str, data_length=255, unique=True),
        Attribute('DatePublished', date, unique=True),
        Attribute('ResourceType', str, data_length=1),
        Attribute('ClassNo', int),
        Attribute('LoanType', str, data_length=1)
    ],
    'Copy': [
        Attribute('Barcode', int, primary_key=True),
        Attribute('ResourceNumber', int, foreign_key='LibResource'),
        Attribute('DateAcquired', datetime),
        Attribute('FloorNo', int),
        Attribute('ShelfNo', int),
        Attribute('Archived', bool, default=False)
    ],
    'Author': [
        Attribute('AuthorNumber', int, primary_key=True),
        Attribute('FirstName', str, data_length=255),
        Attribute('LastName', str, data_length=255),
        Attribute('DOB', date)
    ],
    'AuthorResource': [
        Attribute('AuthorNumber', int, foreign_key='Author', unique=True),
        Attribute('ResourceNumber', int, foreign_key='LibResource', unique=True)
    ],
    'Member': [
        Attribute('LibraryCard', int, primary_key=True),
        Attribute('FirstName', str, data_length=255),
        Attribute('LastName', str, data_length=255),
        Attribute('Email', str, data_length=255, unique=True),
        Attribute('DOB', date),
        Attribute('MemberType', str, data_length=1),
        Attribute('Suspended', bool, default=False)
    ],
    'Loan': [
        Attribute('LoanedCopy', int, foreign_key='Copy.Barcode', unique=True),
        Attribute('LoanedTo', int, foreign_key='Member.LibraryCard', unique=True),
        Attribute('DateLoaned', datetime, unique=True),
        Attribute('DateReturned', datetime, nullable=True)
    ],
    'Fine': [
        Attribute('FinedCopy', int, foreign_key='Copy.Barcode', unique=True),
        Attribute('FineTo', int, foreign_key='Member.LibraryCard', unique=True),
        Attribute('DateFined', datetime, unique=True),
        Attribute('DatePaid', datetime, nullable=True),
        Attribute('FineAmount', Decimal),
        Attribute('AmountPaid', Decimal, nullable=True),
    ],
    'Reservation': [
        Attribute('ReservedResource', int, foreign_key='LibResource.ResourceNumber', 
                  unique=True),
        Attribute('ReservedBy', int, foreign_key='Member.LibraryCard', unique=True),
        Attribute('DateReserved', datetime, unique=True),
        Attribute('DateResolved', datetime, nullable=True),
        Attribute('LastOffered', datetime, nullable=True),
        Attribute('LoanOffers', int, default=0),
        Attribute('Resolution', str, data_length=1, nullable=True)
    ]
}
