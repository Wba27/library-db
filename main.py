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
    if '--scale' in sys.argv and '--scale' != sys.argv[-1]:
        scale_idx = sys.argv.index('--scale') + 1
        scale = sys.argv[scale_idx]
        assert scale.isnumeric(), f"Bad scale argument: '{scale}'"
        scale = int(scale)
    else:
        scale = 5
    gen_script(scale)


if __name__ == '__main__':
    main()
