package testRunner;

import com.intuit.karate.Results;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static com.intuit.karate.Runner.parallel;

public class TestRunner
{
    private static String tag = "@BOOKING_FLOW";

    @Test
    public void TestParallel()
    {
        ArrayList<String> tags = new ArrayList<String>(  );
        tags.add( tag );
        ArrayList<String> paths = new ArrayList<String>(  );
        paths.add( "src/test/resources/features/" );
        Results results = parallel( tags, paths, 1, "target/surefire-reports" );
        generateCucumberReport( results.getReportDir() );
    }

    private static void generateCucumberReport( String karateOutputPath )
    {
        Collection<File> jsonFiles = FileUtils.listFiles( new File( karateOutputPath ), new String[] { "json" }, true );
        List<String> jsonPaths = new ArrayList( jsonFiles.size() );
        jsonFiles.forEach( file -> jsonPaths.add( file.getAbsolutePath() ) );
        Configuration config = new Configuration( new File( "target" ), "Karate Test Automation" );
        ReportBuilder reportBuilder = new ReportBuilder( jsonPaths, config );
        reportBuilder.generateReports();
    }
}
