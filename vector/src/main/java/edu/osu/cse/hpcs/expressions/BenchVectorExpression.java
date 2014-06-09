package edu.osu.cse.hpcs.expressions;

import java.util.HashMap;
import java.util.Map;

import org.apache.hadoop.hive.ql.exec.vector.LongColumnVector;
import org.apache.hadoop.hive.ql.exec.vector.VectorExpressionDescriptor;
import org.apache.hadoop.hive.ql.exec.vector.VectorizationContext;
import org.apache.hadoop.hive.ql.exec.vector.VectorizedRowBatch;
import org.apache.hadoop.hive.ql.exec.vector.expressions.VectorExpression;
import org.apache.hadoop.hive.ql.exec.vector.expressions.gen.LongColAddLongColumn;
import org.apache.hadoop.hive.ql.metadata.HiveException;

public class BenchVectorExpression extends Expression<VectorizedRowBatch[], LongColAddLongColumn> {
  
  public BenchVectorExpression() throws HiveException {
    super();
  }
  
  @Override
  protected VectorizedRowBatch[] dataGen() {
    rowBatchSize = VectorizedRowBatch.DEFAULT_SIZE; // 1024
    int numRowBatches = rowCount / rowBatchSize;
    VectorizedRowBatch[] rowBatches = new VectorizedRowBatch[numRowBatches];
    for (int i = 0; i < numRowBatches; i++) {
      rowBatches[i] = new VectorizedRowBatch(colCount + 1, rowBatchSize);
      for (int j = 0 ; j < colCount; j++) {
        LongColumnVector columnVector = new LongColumnVector(rowBatchSize);
        for (int k = 0; k < rowBatchSize; k ++) {
          columnVector.vector[k] = baseValues[j] + i * rowBatchSize + k;
        }
        rowBatches[i].cols[j] = columnVector;
      }
      // Set up the last column for storing results.
      LongColumnVector columnVector = new LongColumnVector(rowBatchSize);
      rowBatches[i].cols[colCount] = columnVector;
    }    
    return rowBatches;
  }

  @Override
  protected LongColAddLongColumn initExpression() throws HiveException {
    Map<String, Integer> columnMap = new HashMap<String, Integer>();
    for (int i = 0; i < colCount; i++) {
      columnMap.put("col_" + i, i);
    }

    VectorizationContext vc = new VectorizationContext(columnMap, colCount);
    VectorExpression ve =
        vc.getVectorExpression(baseExpression, VectorExpressionDescriptor.Mode.PROJECTION);
    return (LongColAddLongColumn)ve;
  }

  @Override
  public void doEvaluate() throws HiveException {
    long start = System.nanoTime();
    for (int j = 0; j < repetition; j ++) {
      for (int i = 0; i < rowBatches.length; i ++) {
        benchExpressionEvaluator.evaluate(rowBatches[i]);
      }
    }
    long end = System.nanoTime();
    System.out.println("Total time: " + (end - start) / 1000000.0 /repetition + " ms/repetition");
  }
}
