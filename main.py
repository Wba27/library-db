from gen_script import gen_script
import random
import sys


def main():
    if '-r' not in sys.argv:
        if '--seed' in sys.argv and '--seed' != sys.argv[-1]:
            seed_idx = sys.argv.index('--seed') + 1
            random.seed(sys.argv[seed_idx])
        else:
            random.seed('library-db')
    gen_script()


if __name__ == '__main__':
    main()
