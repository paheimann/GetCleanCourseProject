GetCleanCourseProject
=====================

Getting and Cleaning Data Course Project

Github id: paheimann

CODE BOOK: description of variables, data, transformations

This project is based on data collected from the accelerometers in the Samsung Galaxy S smartphone. A full description is available at the web site from which the data were obtained:
 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The experiments were carried out with a group of 30 volunteers (subjects), performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone on the waist. Using its embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial angular velocity.  These raw measures were converted into some additional mechanical measures such as body acceleration, gravity acceleration, jerk, etc.  More information on this conversion is available from the file ‘features_info.txt’ on that web site.

The raw measures were taken at a constant rate of 50Hz over a 2.56 sec interval, resulting in 128 readings per subject per activity per experimental run (there were, on average, 55 experimental runs for each subject/activity combination).  This led to 128 readings for each of the raw measures, and therefore for each of the additional mechanical measures.

These 128 readings were summarized, using statistics such as mean, standard deviation, minimum, maximum, etc.), yielding a total of 561 summary measures.  The complete list of summary measures (variables) is available in the file ’features.txt' on that web site.

The 30 volunteers were separated into two groups, train and test, and their summarized measures were placed into two separate files.

The end result was two sets of files, one for the training subjects and one for the test subjects.  Each set had the following files:
> X: The 561 summary measures for each combination of subject/measure/run

> y: The activity corresponding to each row in X, expressed as an index (1-6)

> subject: The subject (volunteer) corresponding to each row in X


In addition, there were two summary files of interest:
> activity_labels: A lookup table between activity index and activity description

> features.txt: A lookup table between summary measures (feature) and the column of the X matrix

This is the input that we converted into a tidy data set.

In order to do this conversion, we had to do several transformations:
1. Read the training and test files, and combine their rows into a single table, using rbind()
2. Label the 561 columns of this table with the corresponding summary measure
3. Convert the list of activity indices into a list of activity descriptions, and add that as an additional column to the table
4. Add the list of subjects as an additional column to the table
5. Extract only the summary measures of interest, which are the means and standard deviations of the raw and mechanical measures.  There were 68 such summary measures of interest.

In order to create the second tidy data set, we had to do one additional transformation:
6. Compute the mean for each of the summary measures of interest, grouped by the combination of activity and subject.  There were 180 such groupings for the 6 activities and 30 subjects.

