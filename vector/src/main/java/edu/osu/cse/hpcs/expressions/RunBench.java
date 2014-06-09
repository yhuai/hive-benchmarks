package edu.osu.cse.hpcs.expressions;

import org.apache.hadoop.hive.ql.metadata.HiveException;

public class RunBench {

  public static void main(String[] args) throws HiveException {
    if (args[0].equals("vector")) {
      BenchVectorExpression vectorExpr = new BenchVectorExpression();
      System.out.println("Vectorized expression evaluation.");
      System.out.println("=================================");
      vectorExpr.doEvaluate();
    } else {
      BenchNonVectorExpression regularExpr = new BenchNonVectorExpression();   
      System.out.println("Regular expression evaluation.");
      System.out.println("=================================");
      regularExpr.doEvaluate();
    }
  }
}
