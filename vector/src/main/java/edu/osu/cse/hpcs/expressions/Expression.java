package edu.osu.cse.hpcs.expressions;

import java.util.ArrayList;
import java.util.List;

import org.apache.hadoop.hive.conf.HiveConf;
import org.apache.hadoop.hive.ql.metadata.HiveException;
import org.apache.hadoop.hive.ql.plan.ExprNodeColumnDesc;
import org.apache.hadoop.hive.ql.plan.ExprNodeDesc;
import org.apache.hadoop.hive.ql.plan.ExprNodeGenericFuncDesc;
import org.apache.hadoop.hive.ql.session.SessionState;
import org.apache.hadoop.hive.ql.udf.generic.GenericUDFOPPlus;
import org.apache.hadoop.hive.serde2.objectinspector.ObjectInspector;
import org.apache.hadoop.hive.serde2.typeinfo.TypeInfo;
import org.apache.hadoop.hive.serde2.typeinfo.TypeInfoFactory;
import org.apache.hadoop.hive.serde2.typeinfo.TypeInfoUtils;

public abstract class Expression<T, E> {

  protected HiveConf hive;

  protected final int rowCount = 16 * 1024 * 1024;
  protected final int colCount = 4; // 4 columns.

  protected T rowBatches;
  protected int rowBatchSize; // The number of rows in a row batch.
  protected List<String> colNames;
  protected List<TypeInfo> colTypeInfos;
  protected TypeInfo rowTypeInfo;
  protected ObjectInspector objectInspector;
  protected final long[] baseValues;
  
  protected ExprNodeGenericFuncDesc baseExpression;
  protected E benchExpressionEvaluator;
  
  protected final int repetition = 100;

  public Expression() throws HiveException {
    // Arithmetic operations rely on getting conf from SessionState, need to initialize here.
    hive = new HiveConf();
    SessionState ss = new SessionState(hive);
    SessionState.setCurrentSessionState(ss);
    createRowType();
    baseValues = new long[colCount];
    for (int i = 0; i < colCount; i++) {
      baseValues[i] = i + 1;
    }
    rowBatches = dataGen();
    baseExpression = initBaseExpression();
    benchExpressionEvaluator = initExpression();
  }

  private void createRowType() {
    colNames = new ArrayList<String>(colCount);
    colTypeInfos = new ArrayList<TypeInfo>(colCount);
    for (int i = 0; i < colCount; i++) {
      colNames.add("col_" + i);
      colTypeInfos.add(TypeInfoFactory.getPrimitiveTypeInfoFromJavaPrimitive(Long.class));
    }
    rowTypeInfo = TypeInfoFactory.getStructTypeInfo(colNames, colTypeInfos);
    objectInspector = TypeInfoUtils.getStandardJavaObjectInspectorFromTypeInfo(rowTypeInfo);
  }
  
  protected abstract T dataGen();

  private ExprNodeGenericFuncDesc initBaseExpression() {
    GenericUDFOPPlus plusOp = new GenericUDFOPPlus();
    
    List<ExprNodeDesc> children = new ArrayList<ExprNodeDesc>(2);
    ExprNodeColumnDesc colDesc1 = new ExprNodeColumnDesc(Long.class, "col_1", "table", false);
    ExprNodeColumnDesc colDesc3 = new ExprNodeColumnDesc(Long.class, "col_3", "table", false);

    children.add(colDesc1);
    children.add(colDesc3);

    ExprNodeGenericFuncDesc longColAddLongColumn =
        new ExprNodeGenericFuncDesc(TypeInfoFactory.longTypeInfo, plusOp, children);
    return longColAddLongColumn;
  }
  
  protected abstract E initExpression() throws HiveException;

  public abstract void doEvaluate() throws HiveException;
  
}
