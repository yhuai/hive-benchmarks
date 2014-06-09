package edu.osu.cse.hpcs.expressions;

import org.apache.hadoop.hive.ql.exec.ExprNodeEvaluatorFactory;
import org.apache.hadoop.hive.ql.exec.ExprNodeGenericFuncEvaluator;
import org.apache.hadoop.hive.ql.metadata.HiveException;

public class BenchNonVectorExpression extends Expression<Long[][], ExprNodeGenericFuncEvaluator> {
  
  public BenchNonVectorExpression() throws HiveException {
    super();
    rowBatchSize = 1;
  }

  @Override
  protected Long[][] dataGen() {
    Long[][] rows = new Long[rowCount][colCount];
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0 ; j < colCount; j++) {
        rows[i][j] = baseValues[j] + i;
      }  
    }
    return rows;
  }

  @Override
  protected ExprNodeGenericFuncEvaluator initExpression() throws HiveException {
    return (ExprNodeGenericFuncEvaluator)ExprNodeEvaluatorFactory.get(baseExpression);
  }

  @Override
  public void doEvaluate() throws HiveException {    
    benchExpressionEvaluator.initialize(objectInspector);
    Object[] results = new Object[rowBatches.length];
    long start = System.nanoTime();
    for (int j = 0; j < repetition; j ++) {
      for (int i = 0; i < rowBatches.length; i ++) {
        results[i] = benchExpressionEvaluator.evaluate(rowBatches[i]);
      }
    }
    long end = System.nanoTime();
    System.out.println("Total time: " + (end - start) / 1000000.0 /repetition + " ms/repetition");
  }
}
