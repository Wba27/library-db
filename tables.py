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
    
    def __eq__(self, __value: object) -> bool:
        return self.name == __value.name


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
        Attribute('DatePublished', date, unique=True),
        Attribute('ClassNo', int, foreign_key='Subject'),
        Attribute('LoanType', str, data_length=1, 
                  check=Check(CHECK_TYPE.IN, ('L', 'S', 'N'))),
        Attribute('Edition', str, data_length=255, unique=True),
        Attribute('PageLength', int)
    ],
    'AVMedia': [
        Attribute('ResourceNumber', int, primary_key=True),
        Attribute('Title', str, data_length=255, unique=True),
        Attribute('DatePublished', date, unique=True),
        Attribute('ClassNo', int, foreign_key='Subject'),
        Attribute('LoanType', str, data_length=1, 
                  check=Check(CHECK_TYPE.IN, ('L', 'S', 'N'))),
        Attribute('MediaLength', int),
        Attribute('MediaType', str, data_length=1, 
                  check=Check(CHECK_TYPE.IN, ('D', 'C', 'V')))
    ],
    'Copy': [
        Attribute('BarcodeNumber', int, primary_key=True),
        Attribute('BookNumber', int, foreign_key='Book.ResourceNumber', nullable=True,
                  check=Check(CHECK_TYPE.XOR)),
        Attribute('AVNumber', int, foreign_key='AVMedia.ResourceNumber', nullable=True,
                  check=Check(CHECK_TYPE.XOR)),
        Attribute('AcquiredTimestamp', datetime),
        Attribute('FloorNo', int),
        Attribute('ShelfNo', int),
        Attribute('Archived', bool, default=False)
    ],
    'Creator': [
        Attribute('CreatorNumber', int, primary_key=True),
        Attribute('FirstName', str, data_length=255),
        Attribute('LastName', str, data_length=255),
        Attribute('DOB', date)
    ],
    'CreatorResource': [
        Attribute('CreatorNumber', int, foreign_key='Creator', unique=True),
        Attribute('BookNumber', int, foreign_key='Book.ResourceNumber', unique=True, 
                  nullable=True, check=Check(CHECK_TYPE.XOR)),
        Attribute('AVNumber', int, foreign_key='AVMedia.ResourceNumber', unique=True, 
                  nullable=True, check=Check(CHECK_TYPE.XOR)),
        Attribute('CreatorType', str, data_length=1, check=Check(CHECK_TYPE.IN, ('A', 'D')))
    ],
    'Member': [
        Attribute('LibraryCardNumber', int, primary_key=True),
        Attribute('FirstName', str, data_length=255),
        Attribute('LastName', str, data_length=255),
        Attribute('Email', str, data_length=255, unique=True),
        Attribute('DOB', date),
        Attribute('MemberType', str, data_length=1, check=Check(CHECK_TYPE.IN, ('S', 'T'))),
        Attribute('Suspended', bool, default=False)
    ],
    'Loan': [
        Attribute('LoanNumber', int, primary_key=True),
        Attribute('LoanedCopy', int, foreign_key='Copy.BarcodeNumber', unique=True),
        Attribute('LoanedTo', int, foreign_key='Member.LibraryCardNumber'),
        Attribute('LoanedTimestamp', datetime),
        Attribute('ReturnedTimestamp', datetime, nullable=True, unique=True)
    ],
    'Offer': [
        Attribute('ForReservation', int),
        Attribute('OfferedCopy', int, foreign_key='Copy.BarcodeNumber'),
        Attribute('OfferedTimestamp', datetime),
        Attribute('Status', str, data_length=1, check=Check(CHECK_TYPE.IN, ('P', 'A', 'R')))
    ],
    'Fine': [
        Attribute('FinedLoan', int, foreign_key='Loan.LoanNumber', unique=True),
        Attribute('FineTo', int, foreign_key='Member.LibraryCardNumber'),
        Attribute('FinedTimestamp', datetime),
        Attribute('PaidTimestamp', datetime, nullable=True),
        Attribute('FineAmount', Decimal)
    ],
    'Reservation': [
        Attribute('ReservationNumber', int, primary_key=True),
        Attribute('ReservedBook', int, foreign_key='Book.ResourceNumber', 
                  unique=True, nullable=True, check=Check(CHECK_TYPE.XOR)),
        Attribute('ReservedAVMedia', int, foreign_key='AVMedia.ResourceNumber', unique=True, 
                  nullable=True, check=Check(CHECK_TYPE.XOR)),
        Attribute('ReservedBy', int, foreign_key='Member.LibraryCardNumber', unique=True),
        Attribute('ReservedTimestamp', datetime),
        Attribute('ResolvedTimestamp', datetime, nullable=True, unique=True),
        Attribute('Resolution', str, data_length=1, nullable=True, 
                  check=Check(CHECK_TYPE.IN, ('P', 'A', 'R')))
    ],
    'MemberMaxLoans': [
        Attribute('MemberType', str, data_length=1, check=Check(CHECK_TYPE.IN, ('S', 'T')),
                  unique=True),
        Attribute('MaxCopiesOnLoan', int)
    ]
}
