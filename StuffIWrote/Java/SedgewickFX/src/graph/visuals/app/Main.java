package graph.visuals.app;

import javafx.application.Application;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

/**
 * Ethan Petuchowski 5/30/16
 */
public class Main extends Application {

    public static void main(String[] args) {
        launch(args);
    }

    // The start() method is called when the system is ready for
    // the application to begin running.
    @Override public void start(Stage primaryStage) throws Exception {
        // A Group node contains an ObservableList of children that are
        // rendered in order whenever this node is rendered.
        Group root = new Group();

        // Scene is the container for all content in a scene graph.
        // Its size and fill are initialized during construction.
        Scene scene = new Scene(root, 500, 500, Color.BLACK);
        Interactive interactive = new Interactive(scene);
        primaryStage.setTitle("Interactive Graph Application");

        // sceneProperty: The Scene to be rendered on this Stage.
        // There can only be one Scene on the Stage at a time,
        // and a Scene can only be on one Stage at a time.
        primaryStage.setScene(scene);

        // Sets visibility to `true`.
        primaryStage.show();
    }
}

