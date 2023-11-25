# library-db

## install
To install you need Python & git installed.

In the directory you want to install, using a command prompt run `git clone https://github.com/EnemigoPython/library-db.git`.

## run
There are no dependencies so you should just be able to run it with no extra steps.

### normal run
To run with the default seed, in the directory run `python main.py`.

### completely random run
To run and get completely random data, run `python main.py -r`.

### seeded run
To get a consistent but random result with a seed, run `python main.py --seed {insert any value}`. The result will be the same every time.

### scaled run
I have added a multiplier functionality to get more or less data, although the precise length of the output is still random and depends on the seed. By default, the multiplier is set to 5. To change the output when running use `python main.py --scale {multiplier}` where the value is a number.