# gcloud-vision
Accessing the Google Cloud Vision API using Python

To access the API, first your google account needs to be set up properly. Instructions can be found at 
https://cloud.google.com/vision/docs/setup

The `gcloud.py` script takes images from a public bucket in Google Cloud Storage. The `gs://` URI can also be substituted by an external 
URL, although these have been found to time out.

The image names are taken from a local directory. A bearer token file needs to be created from a service account and retrieved by the script.

Note that the Google Cloud Vision API has a limit of 10MB for external files, 20MB for files in Google Cloud Storage and 75 megapixels 
overall.

The `getfilesizes.py` script offers a fast way to extract file dimensions from a list of images to calculate the amount of megapixels.
