import sys
import random

# @include
RED, WHITE, BLUE = range(3)


def dutch_flag_partition(pivot_index, A):
    pivot = A[pivot_index]
    # Keep the following invariants during partitioning:
    # bottom group: A[:smaller].
    # middle group: A[smaller:equal].
    # unclassified group: A[equal:larger].
    # top group: A[larger:].
    smaller, equal, larger = 0, 0, len(A)
    # Keep iterating as long as there is an unclassified element.,
    while equal < larger:
        # A[equal] is the incoming unclassified element.
        if A[equal] < pivot:
            A[smaller], A[equal] = A[equal], A[smaller]
            smaller, equal = smaller + 1, equal + 1
        elif A[equal] == pivot:
            equal += 1
        else:  # A[equal] > pivot.
            larger -= 1
            A[equal], A[larger] = A[larger], A[equal]
# @exclude


def main():
    for _ in range(1000):
        n = int(sys.argv[1]) if len(sys.argv) == 2 else random.randint(1, 100)
        A = [random.randint(0, 2) for _ in range(n)]
        pivot_index = random.randrange(n)
        pivot = A[pivot_index]
        dutch_flag_partition(pivot_index, A)
        i = 0
        while i < len(A) and A[i] < pivot:
            print(A[i], end=' ')
            i += 1
        while i < len(A) and A[i] == pivot:
            print(A[i], end=' ')
            i += 1
        while i < len(A) and A[i] > pivot:
            print(A[i], end=' ')
            i += 1
        print()
        assert i == len(A)


if __name__ == '__main__':
    main()
