import random
from calendar import monthrange
from typing import Literal
from datetime import date, datetime
from test_data import name_types, resource_types


def random_date(start_year, end_year):
    year, month = (random.randint(start_year, end_year), random.randint(1, 12))
    days_range = monthrange(year, month)
    return date(year=year, month=month, day=random.randint(1, days_range[1]))


def random_datetime(start_year, end_year):
    random_date = random_date(start_year, end_year)
    return datetime(
        year=random_date.year, 
        month=random_date.month, 
        day=random_date.day,
        hour=random.randint(9, 20),
        minute=random.randint(1, 60),
        second=random.randint(1, 60)
    )


def random_name():
    return random.choice(name_types['first']), random.choice(name_types['last'])


def random_resource(resource_type: Literal['academic', 'fiction', 'non-fiction']):
    if resource_type == 'academic':
        resource: str = random.choice(resource_types['academic']['main'])
        if random.randint(0, 1) == 1:
            prefix = random.choice(resource_types['academic']['prefix'])
            resource = prefix + resource
        if random.randint(0, 3) == 3:
            suffix = random.choice(resource_types['academic']['suffix'])
            resource = resource + suffix
        return resource
    if resource_type == 'fiction':
        if random.randint(0, 5) == 5:
            adverb = random.choice(resource_types['fiction']['adverb'])
            adjective = random.choice(resource_types['fiction']['adjective'])
            return f'The {adverb} {adjective}' if random.randint(0, 2) == 2 else f'{adverb} {adjective}'
        noun = random.choice(resource_types['fiction']['noun'])
        if random.randint(0, 4) == 4:
            noun = noun + 's'
        if random.randint(0, 3) == 3:
            prefix = random.choice(resource_types['fiction']['prefix'])
            return f'{prefix} {noun}'
        if random.randint(0, 2) >= 1:
            adjective = random.choice(resource_types['fiction']['adjective'])
            return f'The {adjective} {noun}' if random.randint(0, 3) >= 2 else f'{adjective} {noun}'
        return noun if random.randint(0, 7) >= 2 else f'The {noun}'
    if resource_type == 'non-fiction':
        if random.randint(0, 5) == 5:
            if random.randint(0, 5) == 5:
                return random.choice(resource_types['non-fiction']['complete-title'])
            name = random_name()
            suffix = random.choice(resource_types['non-fiction']['biography-suffix'])
            return f'{name[0]} {name[1]}{suffix}' if random.randint(0, 2) >= 1 else f'{name[1]}{suffix}'
        subject: str = random.choice(resource_types['non-fiction']['subject'])
        if random.randint(0, 4) == 4:
            subject = subject[0].upper() + subject[1:]
            second_subject = random.choice(resource_types['non-fiction']['subject'])
            return f'{subject} and {second_subject}'
        if random.randint(0, 1) == 1:
            prefix = random.choice(resource_types['non-fiction']['prefix'])
            return prefix + subject
        subject = subject[0].upper() + subject[1:]
        suffix = random.choice(resource_types['non-fiction']['suffix'])
        return subject + suffix


class Human:
    h_type_count = {}
    def __init__(self, h_type, first_name, last_name, date_of_birth):
        if Human.h_type_count.get(h_type) is not None:
            Human.h_type_count[h_type] += 1
            self.id = Human.h_type_count[h_type]
        else:
            Human.h_type_count[h_type] = 0
            self.id = 0
        self.first_name = first_name
        self.last_name = last_name
        self.email = f'{first_name}.{last_name}{self.id}@qmul.ac.uk'
        self.date_of_birth = date_of_birth


def get_random_human(h_type: str, dob_year_start: int, dob_year_end: int):
    first, last = random_name()
    date_of_birth = random_date(dob_year_start, dob_year_end)
    return Human(h_type, first, last, date_of_birth)


class Resource:
    r_count = -1
    def __init__(self, title, date_published, res_type, class_no, loan_type):
        Resource.r_count += 1
        self.id = Resource.r_count
        self.title = title
        self.date_published = date_published
        self.resource_type = res_type
        self.class_no = class_no
        self.loan_type = loan_type
        self.editions = ['First']
        if random.randint(0, 3) == 3:
            self.editions.append('Second')
            Resource.r_count += 1
            if random.randint(0, 4) == 4:
                self.editions.append('Third')
                Resource.r_count += 1


def get_random_resource(title_type: Literal['academic', 'fiction', 'non-fiction']):
    title = random_resource(title_type)
    date_published = random_date(1980, 2023)
    if random.randint(0, 3) >= 1:
        res_type = 'B'
    else:
        res_type = random.choice(('D', 'C', 'V'))
    class_no = ['academic', 'fiction', 'non-fiction'].index(title_type)
    if random.randint(0, 3) == 3:
        if random.randint(0, 5) == 5:
            loan_type = 'N'
        else:
            loan_type = 'S'
    else:
        loan_type = 'L'
    return Resource(title, date_published, res_type, class_no, loan_type)


class Copy:
    c_count = -1
    def __init__(self, resource_number, date_acquired, floor_no, shelf_no, archived):
        Copy.c_count += 1
        self.id = Copy.c_count
        self.resource_number = resource_number
        self.date_acquired = date_acquired
        self.floor_no = floor_no
        self.shelf_no = shelf_no
        self.archived = archived


def get_random_copy(resource_number, floor_no, base_shelf, base_datetime):
    if random.randint(0, 3) == 3:
        variation = 1 if random.randint(0, 1) == 0 else -1
        shelf_no = min(1, max(15, base_shelf + variation))
    else:
        shelf_no = base_shelf
    if random.randint(0, 1) == 1:
        date_acquired = random_datetime(2012, 2023)
    else:
        date_acquired = base_datetime
    archived = False if random.randint(0, 9) == 9 else True
    return Copy(resource_number, date_acquired, floor_no, shelf_no, archived)


def get_copies_of_resource(resource_number):
    floor_no = random.randint(1, 3)
    base_shelf = random.randint(1, 15)
    base_datetime = random_datetime(2012, 2023)
    return [get_random_copy(
        resource_number, 
        floor_no, 
        base_shelf, 
        base_datetime
    ) for _ in random.randint(1, 5)]


def weighted_random(minimum: int, limit: int, probability: int, sloping=True):
    i = minimum
    dice_roll = probability
    while i < limit and random.randint(0, dice_roll) == 0:
        i += 1
        if sloping:
            dice_roll += 1
    return i
