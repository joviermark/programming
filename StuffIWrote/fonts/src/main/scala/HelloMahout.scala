import java.io.File
import java.util
import org.apache.mahout.cf.taste.impl.model.file.FileDataModel
import org.apache.mahout.cf.taste.impl.neighborhood.NearestNUserNeighborhood
import org.apache.mahout.cf.taste.impl.recommender.GenericUserBasedRecommender
import org.apache.mahout.cf.taste.impl.similarity.PearsonCorrelationSimilarity
import org.apache.mahout.cf.taste.model.DataModel
import org.apache.mahout.cf.taste.neighborhood.UserNeighborhood
import org.apache.mahout.cf.taste.recommender.{Recommender, RecommendedItem}
import org.apache.mahout.cf.taste.similarity.UserSimilarity

/**
 * Base Source:
 * fady64
 * https://github.com/fady64/com.rukbysoft.examples.mahout/blob/MahoutRecommender/src/main/java/com/rukbysoft/examples/mahout/recommender/MovieRecommender.java
 */

object A extends App {

  val model: DataModel = new FileDataModel(new File(
    "/Users/Ethan/Dropbox/CSyStuff/ProgrammingGit/StuffIWrote/fonts/src/main/scala/MoviesList.csv"
  ))

  val similarity: UserSimilarity = new PearsonCorrelationSimilarity(model)
  val neighborhood: UserNeighborhood = new NearestNUserNeighborhood(2, similarity, model)
  val recommender: Recommender = new GenericUserBasedRecommender(model, neighborhood, similarity)
  import scala.collection.JavaConversions._
  val recommendations: util.List[RecommendedItem] = recommender.recommend(1, 1)
  for (recommendation <- recommendations) {
    System.out.println(recommendation)
  }
}