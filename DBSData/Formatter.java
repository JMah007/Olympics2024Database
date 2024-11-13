import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;



public class Formatter{
    public static void main(String args[]){

    String data;
    String insertStatement;
    String inputFileName = args[0];
    String outputFileName = args[1];
    File myObj = null;  //pointer to input file
    FileWriter fWriter = null; //pointer to output file
    
    

    try {
      myObj = new File(inputFileName);
      Scanner myReader = new Scanner(myObj);
      data = myReader.nextLine(); // Throw away first title row

      fWriter = new FileWriter(outputFileName); // create and open the output file for writing

      while (myReader.hasNextLine()) {
        data = myReader.nextLine();

        switch(inputFileName){
          case "countriesData.csv":
            

            insertStatement = countries(data);
            writeToFile(insertStatement, fWriter);
          break;

          case "coachesData.csv":
            insertStatement = coaches(data);
            writeToFile(insertStatement, fWriter);
          break;

          case "medalData.csv":
            insertStatement = medals(data);
            writeToFile(insertStatement, fWriter);
          break;

          case "athleteData.csv":
            insertStatement = athletes(data);
            writeToFile(insertStatement, fWriter);
          break;

          case "technicalOfficialsData.csv":
            insertStatement = technicalOfficials(data);
            writeToFile(insertStatement, fWriter);
          break;

          case "teamData.csv":
            insertStatement = teams(data);
            writeToFile(insertStatement, fWriter);
          break;
        }


      }

      System.out.println("File: " + outputFileName + " created successfully!");

      myReader.close();
      fWriter.close();

    } catch (FileNotFoundException e) {
      System.out.println("An error occurred.");
      e.printStackTrace();
    }
    catch (IOException e) {

            // Print the exception
            System.out.print(e.getMessage());
        }
  }


  public static String countries(String data){
    String insertStatement;

    String[] countryAttributes = data.split(",");

    insertStatement = "INSERT INTO Countries VALUES('" + countryAttributes[1].trim().replace("'", "''") + "', '" + countryAttributes[0].trim().replace("'", "''") + "');";

    return insertStatement;

  }

  public static String coaches(String data){
    String insertStatement;

    String[] coachAttributes = data.split(",");

    insertStatement = "INSERT INTO Coach VALUES('" + coachAttributes[0].trim().replace("'", "''") + "', '" + coachAttributes[1].trim().replace("'", "''") + "', '" +coachAttributes[2].trim().replace("'", "''") + "', '" + coachAttributes[3].trim().replace("'", "''") + "', '" + coachAttributes[4].trim().replace("'", "''") + "');";

    return insertStatement;

  }

  public static String medals(String data){
    String insertStatement;

    String[] medalAttributes = data.split(",");

    insertStatement = "INSERT INTO Medals VALUES('" + medalAttributes[0].trim().replace("'", "''") + "', '" + medalAttributes[1].trim().replace("'", "''") + "', '" + medalAttributes[2].trim().replace("'", "''") + "');";

    return insertStatement;

  }


  public static String athletes(String data){
    String insertStatement;

    String[] medalAttributes = data.split(",");

    if((medalAttributes[2].trim().replace("'", "''")).equals("Male")){
      medalAttributes[2] = "M";
    }
    if((medalAttributes[2].trim().replace("'", "''")).equals("Female")){
      medalAttributes[2] = "F";
    }

    insertStatement = "INSERT INTO Athletes VALUES('" + medalAttributes[0].trim().replace("'", "''") + "', '" + medalAttributes[1].trim().replace("'", "''") + "', '" + medalAttributes[2].trim().replace("'", "''") + "', " + "NULL" + ", '" + medalAttributes[3].trim().replace("'", "''") + "');";

    return insertStatement;

  }

  public static String technicalOfficials(String data){
    String insertStatement;

    String[] medalAttributes = data.split(",");

    if((medalAttributes[2].trim().replace("'", "''")).equals("Male")){
      medalAttributes[2] = "M";
    }
    if((medalAttributes[2].trim().replace("'", "''")).equals("Female")){
      medalAttributes[2] = "F";
    }

    insertStatement = "INSERT INTO TechnicalOfficials VALUES('" + medalAttributes[0].trim().replace("'", "''") + "', '" + medalAttributes[1].trim().replace("'", "''") + "', '" + medalAttributes[2].trim().replace("'", "''") + "', '" + medalAttributes[3].trim().replace("'", "''") + "', '" + medalAttributes[4].trim().replaceAll("[\\[\\]']", "") + "');";

    return insertStatement;

  }



  public static String teams(String data){
    String insertStatement;

    String[] teamAttributes = data.split(",");

    if((teamAttributes[4].trim().replace("'", "''")).equals("W")){
      teamAttributes[4] = "F";
    }

    insertStatement = "INSERT INTO Teams VALUES('" + teamAttributes[0].trim().replace("'", "''") + "', '" + teamAttributes[1].trim().replace("'", "''") + "', '" + teamAttributes[2].trim().replace("'", "''") + "', '" + teamAttributes[3].trim().replace("'", "''") + "', '" + teamAttributes[4].trim().replace("'", "''") + "');";

    return insertStatement;

  }



  


  public static void writeToFile(String insertStatement, FileWriter outputFile){

    try {
            outputFile.write(insertStatement + "\n");
        }

        // Catch block to handle if exception occurs
        catch (IOException e) {

            // Print the exception
            System.out.print(e.getMessage());
        }

  }
}


