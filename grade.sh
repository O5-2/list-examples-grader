CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

# Current status: Regex isn't working, trying to fix that

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission 2> grading-area/blank.txt

if ! [[ -f student-submission/ListExamples.java ]]
then
  echo "ListExamples.java not found"
  exit 1
fi

cp student-submission/ListExamples.java grading-area/ListExamples.java
cp *.java grading-area/
cp -r lib grading-area/lib

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar grading-area/*.java
if [[ $? -ne 0 ]]
then
  echo "Error during compilation"
  exit 1
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore grading-area/TestListExamples > grading-area/result.txt
regexOne='/(\d+)/'
regexTwo='/(\d+).*(\d+)/'

grepOne=`grep "OK" grading-area/result.txt`
grepTwo=`grep "Tests run" grading-area/result.txt`
echo "GREP TEST"
echo $grepTwo
echo "GREP TEST"
if [[ $grepOne != "" ]]
then
  echo "Perfect score"
  [[ $grepOne =~ $regexOne ]]
  echo "${BASH_REMATCH[1]} out of ${BASH_REMATCH[1]} tests passed"
else
  echo "Some tests failed"
  [[ $grepTwo =~ $regexTwo ]]
  echo "${BASH_REMATCH[1]} out of ${BASH_REMATCH[2]} tests passed"
fi
