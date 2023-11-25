from gen_script import gen_script
import random
import sys
import timeit


def main():
    if '-r' not in sys.argv:
        if '--seed' in sys.argv and '--seed' != sys.argv[-1]:
            seed_idx = sys.argv.index('--seed') + 1
            seed = sys.argv[seed_idx]
        else:
            seed = 'library-db'
        random.seed(seed)
    if '--scale' in sys.argv and '--scale' != sys.argv[-1]:
        scale_idx = sys.argv.index('--scale') + 1
        scale = sys.argv[scale_idx]
        assert scale.isnumeric(), f"Bad scale argument: '{scale}'"
        scale = int(scale)
    else:
        scale = 5
    print(f'Seed: {seed}, scale: {scale}')
    start_time = timeit.default_timer()
    gen_script(scale)
    end_time = timeit.default_timer()
    print(f'Done in {round((end_time - start_time) * 1000, 4)} ms')


if __name__ == '__main__':
    main()
