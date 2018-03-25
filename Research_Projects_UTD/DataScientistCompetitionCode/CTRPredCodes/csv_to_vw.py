# author = "Toby Cheese"
# license: do whatever you want with it, really

import csv
import os


# tune this to fit your input file
train = "train.csv"
delimiter=','
quoting=csv.QUOTE_NONE
identifier_index = 0 # column index of the row identifier
prediction_index = 1 # column index that contains the prediction
numerical_indices = []
categorical_indices = range(2,22) # all except id and the prediction


def __get_linecount(path):
    with open(path, 'rU') as f:
        num_of_lines = sum(1 for row in f)
    return num_of_lines

def __read_file(path):
    with open(path, 'rU') as data:
        reader = csv.reader(data, delimiter=delimiter, quoting=quoting)
        for row in reader:
          yield row

num_of_lines = __get_linecount(train) # only needed to report progress

# automatically (but stupidly) decide whether working on a training or test file
path_and_filename, _ = os.path.splitext(train)
is_trainingset = True if path_and_filename.find('train')>=0 else False

with open(path_and_filename + '.vw', 'w ') as fw:
    for line_no, line in enumerate(__read_file(train)):

        # build field name lookup dict and open file
        if line_no == 0:
            lookup = {key: val for (key, val) in enumerate(line)}
            continue

        if is_trainingset:
            # the *2-1 below turns prediction of {0,1} into {-1,1}
            out =  "{0} |".format(int(line[prediction_index])*2-1)
        else:
            # the missing whitespace before the pipe is intentional
            out =  "{0}|".format(int(line[identifier_index]))

        # yes, that looks a bit cryptic
        out += " ".join([" {0}:{1}".format(lookup[index], item) for index, item in enumerate(line) if index in numerical_indices]) + \
               " ".join([" {0}_{1}".format(lookup[index], item) for index, item in enumerate(line) if index in categorical_indices]) + \
               "\n"

        # and write to file
        fw.write(out)

        # print progress
        if (line_no % 100000) == 0:
            print "{0} lines of {1} written ({2}%)".format(line_no, num_of_lines, 100*line_no/num_of_lines)

        # restrict to a certain number of lines (don't forget to shuffle input file if you do this)
        #if line_no == 50000:
        #    break