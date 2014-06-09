This program tests the performance of the plus expression on two columns with and without the vectorized expression evaluator.

# Build
`mvn clean package`

# Run
Example:
Vectorized version: `time java -jar -XX:+PrintCompilation target/vector-perf-0.0.1-SNAPSHOT.jar vector`
Regular version: `time java -jar -XX:+PrintCompilation target/vector-perf-0.0.1-SNAPSHOT.jar regular`
