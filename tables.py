from dataclasses import dataclass
from datetime import datetime, date
from decimal import Decimal
from enum import Enum

CHECK_TYPE = Enum('Check', ['IN', 'XOR'])


@dataclass
class Check:
    name: CHECK_TYPE
    data: any = None

    def __hash__(self) -> int:
        return hash(self.name)


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
    check: Check = None

tables = {
    'Subject': [
        Attribute('ClassNo', int, primary_key=True),
        Attribute('SubjectName', str, data_length=255, unique=True)
    ],
    'Book': [
        Attribute('ResourceNumber', int, primary_key=True),
        Attribute('Title', str, data_length=255, unique=True),
        Attribute('Edition', str, data_length=255, unique=True),
        Attribute('DatePublished', date, unique=True),
        Attribute('ClassNo', int, foreign_key='Subject'),
        Attribute('LoanType', str, data_length=1),
        Attribute('PageLength', int)
    ],
    'AVMedia': [
        Attribute('ResourceNumber', int, primary_key=True),
        Attribute('Title', str, data_length=255, unique=True),
        Attribute('Edition', str, data_length=255, unique=True),
        Attribute('DatePublished', date, unique=True),
        Attribute('ClassNo', int, foreign_key='Subject'),
        Attribute('LoanType', str, data_length=1),
        Attribute('MediaLength', int),
        Attribute('MediaType', str, data_length=1)
    ],
    'Copy': [
        Attribute('Barcode', int, primary_key=True),
        Attribute('BookNumber', int, foreign_key='Book.ResourceNumber', nullable=True,
                  check=Check(CHECK_TYPE.XOR)),
        Attribute('AVNumber', int, foreign_key='AVMedia.ResourceNumber', nullable=True,
                  check=Check(CHECK_TYPE.XOR)),
        Attribute('AcquiredTimestamp', datetime),
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
        Attribute('BookNumber', int, foreign_key='Book.ResourceNumber', unique=True, 
                  nullable=True, check=Check(CHECK_TYPE.XOR)),
        Attribute('AVNumber', int, foreign_key='AVMedia.ResourceNumber', unique=True, 
                  nullable=True, check=Check(CHECK_TYPE.XOR))
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
        Attribute('LoanedTimestamp', datetime, unique=True),
        Attribute('ReturnedTimestamp', datetime, nullable=True)
    ],
    'Offer': [
        Attribute('ReservationNo', int, primary_key=True),
        Attribute('OfferedCopy', int, foreign_key='Copy.Barcode'),
        Attribute('OfferedDate', datetime),
        Attribute('Status', str, data_length=1)
    ],
    'Fine': [
        Attribute('FinedCopy', int, foreign_key='Copy.Barcode', unique=True),
        Attribute('FineTo', int, foreign_key='Member.LibraryCard', unique=True),
        Attribute('FinedTimestamp', datetime, unique=True),
        Attribute('PaidTimestamp', datetime, nullable=True),
        Attribute('FineAmount', Decimal)
    ],
    'Reservation': [
        Attribute('ReservationNo', int, primary_key=True),
        Attribute('ReservedBook', int, foreign_key='Book.ResourceNumber', 
                  unique=True, nullable=True, check=Check(CHECK_TYPE.XOR)),
        Attribute('ReservedAVMedia', int, 
                  foreign_key='AVMedia.ResourceNumber', unique=True, nullable=True),
        Attribute('ReservedBy', int, foreign_key='Member.LibraryCard', unique=True,
                  check=Check(CHECK_TYPE.XOR)),
        Attribute('ReservedTimestamp', datetime, unique=True),
        Attribute('ResolvedTimestamp', datetime, nullable=True),
        Attribute('Resolution', str, data_length=1, nullable=True)
    ],
    'MemberMaxLoans': [
        Attribute('MemberType', str, foreign_key='Member', data_length=1),
        Attribute('MaxCopiesOnLoan', int)
    ]
}
