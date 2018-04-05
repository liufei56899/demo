package com.thinkgem.jeesite.common.utils;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

/**
 * @author Hongten
 * 
 * @time 2011-12-12 2011
 */
public class FileTxtUtils{
    @SuppressWarnings("static-access")
    public static void main(String[] args) {
    	String filenameTemp="D:/apache-tomcat-7.0.40/webapps/em/WEB-INF/templet/printCode.txt";
    	FileTxtUtils myFile = new FileTxtUtils();
        String str = myFile.readFile(filenameTemp);
        System.out.println(str);
    }

    /**
     * 写文件
     * 
     * @param newStr
     *            新内容
     * @throws IOException
     */
    public static void writeFile(String fileName, String fileContent)   
    {     
        try   
        {      
            File f = new File(fileName);      
            if (!f.exists())   
            {       
                f.createNewFile();      
            }      
            OutputStreamWriter write = new OutputStreamWriter(new FileOutputStream(f),"gbk");      
            BufferedWriter writer=new BufferedWriter(write);          
            writer.write(fileContent);      
            writer.close();     
        } catch (Exception e)   
        {      
            e.printStackTrace();     
        }  
    }  
    /**
     * 读取数据
     */
    public static String readFile(String fileName)  
    {     
        String fileContent = "";     
        try   
        {       
            File f = new File(fileName);      
            if(f.isFile()&&f.exists())  
            {       
                InputStreamReader read = new InputStreamReader(new FileInputStream(f),"gbk");       
                BufferedReader reader=new BufferedReader(read);       
                String line;       
                while ((line = reader.readLine()) != null)   
                {        
                    fileContent += line+"\r\n";       
                }         
                read.close();      
            }     
        } catch (Exception e)   
        {         
            e.printStackTrace();     
        }     
        return fileContent;   
    }   
}
