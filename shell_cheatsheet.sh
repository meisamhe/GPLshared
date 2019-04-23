Bash Commands
uname -a Show system and kernel
head -n1 /etc/issue Show distribution
mount Show mounted
filesystems
date Show system date
uptime Show uptime
whoami Show your username
man command Show manual for
command
Bash Shortcuts
CTRL-c Stop current command
CTRL-z Sleep program
CTRL-a Go to start of line
CTRL-e Go to end of line
CTRL-u Cut from start of line
CTRL-k Cut to end of line
CTRL-r Search history
!! Repeat last command
!abc Run last command starting with
abc
!abc:p Print last command starting with
abc
!$ Last argument of previous
command
ALT-. Last argument of previous
command
!* All arguments of previous
command
^abc^123 Run previous command, replacing
abc with 123
Bash Variables
env Show environment variables
echo $NAME Output value of $NAME
variable
Bash Variables (cont)
export NAME=value Set $NAME to value
$PATH Executable search path
$HOME Home directory
$SHELL Current shell
IO Redirection
cmd < file
Input of cmd from file
cmd1 <(cmd2)
Output of cmd2 as file input tocmd1
cmd > file
Standard output (stdout) of cmd to file
cmd > /dev/null
Discard stdout of cmd
cmd >> file
Append stdout to file
cmd 2> file
Error output (stderr) of cmd to file
cmd 1>&2
stdout to same place as stderr
cmd 2>&1
stderr to same place as stdout
cmd &> file
Every output of cmd to file
cmd refers to a command.
Pipes
cmd1 | cmd2
stdout of cmd1 to cmd2
cmd1 |& cmd2
stderr of cmd1 to cmd2
Command Lists
cmd1 ; cmd2
Run cmd1 then cmd2
cmd1 && cmd2
Run cmd2 if cmd1 is successful
cmd1 || cmd2
Run cmd2 if cmd1 is not successful
cmd &
Run cmd in a subshell
Directory Operations
pwd Show current directory
mkdir dir Make directory dir
cd dir Change directory to dir
cd .. Go up a directory
ls List files
ls Options
-a Show all (including hidden)
-R Recursive list
-r Reverse order
-t Sort by last modified
-S Sort by file size
-l Long listing format
-1 One file per line
-m Comma-separated output
-Q Quoted output
Search Files
grep pattern files Search for pattern in
files
grep -i Case insensitive
search
grep -r Recursive search
grep -v Inverted search
grep -o Show matched part of
file only
find /dir/ -name name* Find files starting with
name in dir
Search Files (cont)
find /dir/ -user name Find files owned by
name in dir
find /dir/ -mmin num Find files modifed less
than num minutes ago in
dir
whereis command Find binary / source /
manual for command
locate file Find file (quick search of
system index)
File Operations
touch file1
Create file1
cat file1 file2
Concatenate files and output
less file1
View and paginate file1
file file1
Get type of file1
cp file1 file2
Copy file1 to file2
mv file1 file2
Move file1 to file2
rm file1
Delete file1
head file1
Show first 10 lines of file1
tail file1
Show last 10 lines offile1
tail -F file1
Output last lines offile1 as it changes
Watch a Command
watch -n 5 'ntpq -p'
Issue the 'ntpq -p' command every 5
seconds and display output
Process Management
ps Show snapshot of processes
top Show real time processes
kill pid Kill process with id pid
pkill name Kill process with name name
killall name Kill all processes with names
beginning name
Nano Shortcuts
Files
Ctrl-R Read file
Ctrl-O Save file
Ctrl-X Close file
Cut and Paste
ALT-A Start marking text
CTRL-K Cut marked text or line
CTRL-U Paste text
Navigate File
ALT-/ End of file
CTRL-A Beginning of line
CTRL-E End of line
CTRL-C Show line number
CTRL-_ Go to line number
Search File
CTRL-W Find
ALT-W Find next
CTRL-\ Search and replace
More nano info at:
http://www.nano-editor.org/docs.php
Screen Shortcuts
screen
Start a screen session.
screen -r
Resume a screen session.
Screen Shortcuts (cont)
screen -list
Show your current screen sessions.
CTRL-A
Activate commands for screen.
CTRL-A c
Create a new instance of terminal.
CTRL-A n
Go to the next instance of terminal.
CTRL-A p
Go to the previous instance of terminal.
CTRL-A 
Show current instances of terminals.
CTRL-A A
Rename the current instance.
More screen info at:
http://www.gnu.org/software/screen/
File Permissions
chmod 775 file
Change mode of file to 775
chmod -R 600 folder
Recursively chmod folder to 600
chown user:group file
Change file owner to user and group to
group
File Permission Numbers
First digit is owner permission, second is group
and third is everyone.
Calculate permission digits by adding numbers
below.
4 read (r)
2 write (w)
1 execute (x)

From existing data
cd ~/projects/myproject
git init
git add .
git clone ~/existing/repo ~/new/repo
git clone git://host.org/project.git
git clone ssh://you@host.org/proj.git
File changes in working directory by:
git status
Changes to tracked files
git diff
what changed between $ID1 and $ID2
git diff $id1 $id2
History of changes
git log
History of changes for file with diffs
git log -p $file $dir/ec/tory
who changed what and when in a file
git blame $file
A commit identified by $ID
git show $idd
A specific file from specific $ID
git show $id:$file
All local branches
git branch
Revert
Revert the last commit
git revert HEAD
Revert specific commit
git revert $id
Checkout the $id version of a file
git checkout $id $file
! you cannot undo a hard reset
Return to the last committed state
git reset --hard
Fix the last commit
git commit -a --amend
(after editing the broken files)
Creates a new commit
Creates a new commit
Branch
Merge branch1 into branch2
git checkout $branch2
git merge branch1
Create branch named $branch based on
the HEAD
git branch $branch
Switch to the $id branch
git checkout $id
Create branch $new_branch based on
branch $other and switch to it
git checkout -b $new_branch $other
Delete branch $branch
git branch -d $branch
Fetch latest changes from origin
Update
git fetch
(but this does not merge them).
Pull latest changes from origin
git pull
(does a fetch followed by a merge)
Apply a patch that some sent you
git am -3 patch.mbox
Finding regressions
git bisect start
git bisect good $id
git bisect bad $id
git bisect bad/good
git bisect visualize
git bisect reset
Check for errors and cleanup repository
git fsck
git gc --prune
Search working directory for foo()
git grep "foo()"
Commit all your local changes
Publish
git commit -a
Prepare a patch for other developers
git format-patch origin
Push changes to origin
git push
To view the merge conclicts
git diff (complete conflict diff)
git diff --base $file (against base file)
git diff --ours $file (against your changes)
git diff --theirs $file (against other changes)

To discard conflicting patch
git reset --hard
git rebase --skip

After resolving conflicts, merge with
git add $conflicting_file
git rebase --continue


Command line hive
----------
hive -e 'select a.col from tab1 a'
hive -S -e 'select a.col from tab1 a'
hive -e 'select a.col from tab1 a' -hiveconf hive.root.logger=DEBUG, console
hive -i initialize.sql
hive -f script.sql

Hive Shell
-----------
source file_name
dfs -ls /user
!ls
set mapred.reduce.tasks=32
set hive.<TAB>
set
reset
add jar jar_path
list jars
delete jar jar_name

Spark
-------------------
$ pwd
$ tar -zxvf spark- 1.0.1.tgz -C /Users/akuntamukkala/spark
$ pwd /
Users/akuntamukkala/spark/spark-1.0.1 akuntamukkala@localhost~/spark/spark-1.0.1$ sbt/sbt assembly
$ /Users/akuntamukkala/spark/spark-1.0.1/bin/spark-sh
ell
$ /Users/akuntamukkala/spark/spark-1.0.1/bin/ pyspark


Hadoop Cheat Sheet
------------------
hadoop dfs <CMD>
-ls <path> : list all files in <path>
-cat <src> : print <src> on stdout
-tail [-f] <file> : output the last part of the <file>
-du <path> : show <path> space utilization
-mkdir <path> : create a directory
-mv <src> <dst> : move (rename) files
-cp <src> <dst> : copy files
-rmr <path> : remove files
-copyFromLocal <localsrc> <dst> : copy a local file to the HDFS
-copyToLocal <src> <localdst> : copy a file on the HDFS to the local disk
-help [cmd] : hopefully this is selfdescribing
hadoop dfs -ls /
hadoop dfs -copyFromLocal myfile remotefile
Copy the jar file of your job to the client machine (let's call it machine_name )
scp localJarFile studentXX@machine_name:~/
SSH to machine_name :
ssh studentXX@machine_name
Launch the job:
hadoop jar jarFile.jar ClassNameWithPackage [job args]
Note that if the output directory exists (and you don't want it) you need to remove it:
hadoop dfs -rmr output
hadoop jar fr.eurecom.dsg.WordCount /user/hadoop/wikismall.xml output 2

sudo mkdir /mnt/$sharename.
sudo chmod 777 /mnt/$sharename.
sudo mount -t vboxsf -o uid=1000,gid=1000 $sharename /mnt/$sharename.
.
sudo rmdir ...
sudo mv ..
zxvf: z: unzip x: extreme, v verbose, f: file.
sudo tar -zxvf ...tar.
root access with current (no sudo).
sudo -s.

sharename="MeisamHPC_shared"   .
sudo chmod 777 /mnt/$sharename.
sudo mount -t vboxsf -o uid=1000,gid=1000 $sharename /mnt/$sharename.

rm -rf MeisamHPC_shared.
.
# some packages not installed on the VM .
# that you might want to add:.
.
sudo apt-get install gitk               # to view git history.
sudo apt-get install xxdiff             # to compare two files.
sudo apt-get install python-sympy       # symbolic python.
sudo apt-get install imagemagick        # so you can "display plot.png".
.
.
sudo apt-get install python-setuptools  # so easy_install is available.
sudo easy_install nose                  # unit testing framework.
sudo easy_install StarCluster           # to help manage clusters on AWS.

#Run Git Bash first.
mkdir /path/to/your/project .
cd /path/to/your/project.
git init .
git remote add origin https://meisamhe@bitbucket.org/meisamhe/textmining.git.
Ls.
Git status.
Git config user.name "meisamhe".
Git config user.email meisam.hejazinia@utdallas.edu.
Git add textminingmarketing/.
Git commit -m "adding textminingmarketing instructions".
Git push -u origin master.

git status | more.
mate mysqrt.py   # a good python editor.
ipython                 # good python editor.
git init                   # in a folder to create version control.
quit                       # to quit an app.
git add mysqrt.py   # to stage before commit.
clear.
git commit -m "first version of script".
prompted.
PS1 = ' $'.
workon claw.
git log.
git checkout 04d22..   --mysqrt.py # to take specific comitted branch.
vi mysqrt.py.
git checkout HEAD mysqrt.py # take out last version.
git clone https://github.com/ipython/ipython.git.
cd ipython.
sudo python setup.py install.
pwd.
export Junk=abc.
printenv Junk.
echo Junk = abc.
cp lecture3.mysqrt lecture4.
git add mysqrt.py.
git reset HEAD        .........py .......py # to not stage two files with py postfix.
git ls-files .        # which files are under version control.
git status .          # for current directory.
ipython -- pylab        # to also import numpy.
vi $HPCir/.gitignore # include files to be ignored by git.
# into the .gitignore at each line put:.
.pyc   # for python compiler.
.o       # for fortran compiler.
git log --author="John Smith" -p hello.py.
git log --stat.
nosetests -v mysqrt.py.
ipython notebook --pylab  inline.
ctrl + Z:  to get to command line.
ctrl + C: to break.
bg  # to send to background.
ipython notebook --pylab inline &.
mate Lecture5a.ipynb.
git add !$.
fg # to get to forward ground.
# Sagemath.org good source of online coding of python created by Washington Uni.

nitialContext ctx = new InitialContext(p);.
.
Example Windows Batch script..
c:\my\app\RunIt.bat.
@echo off.
.
set OPENEJB_HOME=C:\openejb.
set PATH=%PATH%;%OPENEJB_HOME%\bin.
set JAVA=%JAVA_HOME%\bin\java.
.
set CP=.
for %%i in (%OPENEJB_HOME%\lib\*.jar) do call cp.bat %%i .
for %%i in (%OPENEJB_HOME%\dist\*.jar) do call cp.bat %%i .
for %%i in (%OPENEJB_HOME%\beans\*.jar) do call cp.bat %%i .
set CLASSPATH=%JAVA_HOME%\lib\tools.jar;%CP%.
.
%JAVA% %OPTIONS% -Dopenejb.home=%OPENEJB_HOME% org.acme.HelloWorld.
.
Example Linux/Unix Batch script..
/my/app/RunIt.sh.
#!/bin/sh.
.
# Set OPENEJB_HOME to the full path where you .
# installed your OpenEJB distribution.
export OPENEJB_HOME=/openejb.
.
# Set JAVA_HOME to the full path where you .
# installed your JDK distribution.
export JAVA_HOME=/usr/java/jdk1.3.1.
.
.
.
export PATH=${PATH}:${OPENEJB_HOME}/bin.
export JAVA=${JAVA_HOME}/bin/java.
.
export CP=.
CP=`echo $OPENEJB_HOME/lib/*.jar | tr ' ' ':'`:${CP}.
CP=`echo $OPENEJB_HOME/dist/*.jar | tr ' ' ':'`:${CP}.
CP=`echo $OPENEJB_HOME/beans/*.jar | tr ' ' ':'`:${CP}.
export CLASSPATH=$JAVA_HOME/lib/tools.jar:${CP}.
.
$JAVA -Dopenejb.home=$OPENEJB_HOME org.acme.HelloWorld

java -xm2G. #allocate 2GB as memory to avoid memory error.

