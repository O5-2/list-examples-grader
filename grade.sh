CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

# Current status: Bugs fixed, still need to add more tests to TestListExamples
# And need to test on other repositories

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

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar grading-area/*.java > grading-area/compileResult.txt 2> grading-area/compileErrors.txt
if [[ $? -ne 0 ]]
then
  echo "Error during compilation"
  exit 1
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar:./grading-area org.junit.runner.JUnitCore TestListExamples > grading-area/result.txt 2> grading-area/errors.txt
regexOne='([[:digit:]]+)'
regexTwo='([[:digit:]]+).*([[:digit:]]+)'

grepOne=`grep "OK" grading-area/result.txt`
grepTwo=`grep "Tests run" grading-area/result.txt`
if [[ $grepOne != "" ]]
then
  echo "Perfect score"
  [[ $grepOne =~ $regexOne ]]
  echo "${BASH_REMATCH[1]} out of ${BASH_REMATCH[1]} tests passed"
else
  echo "Some tests failed"
  [[ $grepTwo =~ $regexTwo ]]
  echo "$(( ${BASH_REMATCH[1]}-${BASH_REMATCH[2]} )) out of ${BASH_REMATCH[1]} tests passed"
fi
