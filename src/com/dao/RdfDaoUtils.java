/**
 * 查询Rdf文件的数据层方法类
 */
package com.dao;

import com.hp.hpl.jena.query.*;
import com.hp.hpl.jena.rdf.model.Model;
import com.hp.hpl.jena.rdf.model.ModelFactory;
import com.hp.hpl.jena.util.FileManager;
import com.utils.ReadFileUtils;

import java.io.InputStream;

public class RdfDaoUtils {

     private static RdfDaoUtils rdfDaoUtils=null;

    //一个简单的单例模式
    public static RdfDaoUtils createRdfDaoUtils(){

        if(rdfDaoUtils==null){
            rdfDaoUtils=new RdfDaoUtils();
        }
        return rdfDaoUtils;
    }

    private RdfDaoUtils(){

    }

    //想了想还是要读取多次，因为会修改文件
    public Model laodRdfFile() {
        String inputfileName = "E:\\llj\\Users\\Administrator\\IdeaProjects\\dongwuzhishiku\\src\\dongwuku.rdf";
        //创建空的模型
        Model model = ModelFactory.createDefaultModel();
        //FileManager文件管理器
        InputStream open = FileManager.get().open(inputfileName);
        model.read(open, "", "RDF/XML");
        return model;
    }

    public String laodRdfFile1() {
        String inputfileName = "E:\\llj\\Users\\Administrator\\IdeaProjects\\dongwuzhishiku\\src\\dongwuku.rdf";
        //创建空的模型
        String contents=ReadFileUtils.readTxtFile(inputfileName);
        return contents;
    }
    /**
     * 查询
     * @param querySql 查询的sql
     * @return
     */
    public ResultSet queryResult(String querySql){
       return  queryResultSet(selectId(querySql),laodRdfFile());
    }
    //编写查询语句
    private String selectId(String selects) {
        return "PREFIX uni:<http://baike.com/resource/uni-ns#>"
                + "PREFIX rdf:<http://www.w3.org/1999/02/22-rdf-syntax-ns#>"
                + "PREFIX id:<http://baike.com/resource/id-ns#>" + selects;
    }

   private ResultSet queryResultSet(String queryString, Model model) {
        //创建查询
        Query query = QueryFactory.create(queryString);
        //执行查询
        QueryExecution qe = QueryExecutionFactory.create(query, model);
        //返回查询结果
        ResultSet results = qe.execSelect();
        return results;

    }




}
