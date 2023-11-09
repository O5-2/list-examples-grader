import static org.junit.Assert.*;
import org.junit.*;
import java.util.Arrays;
import java.util.List;

class L1aInterface implements StringChecker {
  public boolean checkString(String s) {
    return (s.length() < 2);
  }
}

class IsMoon implements StringChecker {
  public boolean checkString(String s) {
    return s.equalsIgnoreCase("moon");
  }
}

public class TestListExamples {
  @Test(timeout = 500)
  public void testMergeRightEnd() {
    List<String> left = Arrays.asList("a", "b", "c");
    List<String> right = Arrays.asList("a", "d");
    List<String> merged = ListExamples.merge(left, right);
    List<String> expected = Arrays.asList("a", "a", "b", "c", "d");
    assertEquals(expected, merged);
  }

  @Test 
  public void testL1a() {
    List<String> input1 = Arrays.asList("a", "b");
    L1aInterface L1a = new L1aInterface();
    assertEquals(Arrays.asList("a", "b"), ListExamples.filter(input1, L1a));
  }

  @Test 
  public void testL2a() {
    List<String> input1 = Arrays.asList();
    List<String> input2 = Arrays.asList("a");
    assertEquals(Arrays.asList("a"), ListExamples.merge(input1, input2));
  }
}
