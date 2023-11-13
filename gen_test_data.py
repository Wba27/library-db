import random
from calendar import monthrange
from typing import Literal
from datetime import date
from test_data import name_types, resource_types


def random_date(start_year, end_year):
    year, month = (random.randint(start_year, end_year), random.randint(1, 12))
    days_range = monthrange(year, month)
    return date(year=year, month=month, day=random.randint(1, days_range[1]))


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
    def __init__(self, title, edition, date_published, res_type, class_no, loan_type):
        Resource.r_count += 1
        self.id = Resource.r_count
        self.title = title
        self.edition = edition
        self.date_published = date_published
        self.resource_type = res_type
        self.class_no = class_no
        self.loan_type = loan_type


def get_random_resource(edition, title_type: Literal['academic', 'fiction', 'non-fiction']):
    title = random_resource(title_type)
    date_published = random_date(1980, 2023)
    res_type = random.choice('B', 'D', 'C', 'V')
    class_no = ['academic', 'fiction', 'non-fiction'].index(title_type)
    if random.randint(0, 3) == 3:
        if random.randint(0, 5) == 5:
            loan_type = 'N'
        else:
            loan_type = 'S'
    else:
        loan_type = 'N'
    return Resource(title, edition, date_published, res_type, class_no, loan_type)


def weighted_random(minimum: int, limit: int, probability: int, sloping=True):
    i = minimum
    dice_roll = probability
    while i < limit and random.randint(0, dice_roll) == 0:
        i += 1
        if sloping:
            dice_roll += 1
    return i


if __name__ == '__main__':
    random.seed('yeet')
    for i in range(30):
        first, last = random_name()
        h = Human('student', first, last, random_date(1998, 2005))
        print(h.email, h.date_of_birth, h.id)
    # for i in range(60):
    #     first, last = random_name()
    #     h = Human(first, last, random_date(1998, 2005))
    #     res = random_resource('academic')
    #     print(f'{res} by {h.first_name} {h.last_name}')
    # for i in range(60):
    #     first, last = random_name()
    #     h = Human(first, last, random_date(1998, 2005))
    #     res = random_resource('fiction')
    #     print(f'{res} by {h.first_name} {h.last_name}')
    # for i in range(60):
    #     first, last = random_name()
    #     h = Human(first, last, random_date(1998, 2005))
    #     res = random_resource('non-fiction')
    #     print(f'{res} by {h.first_name} {h.last_name}')
