provider "google" {
  credentials = "${file("./creds/serviceaccount.json")}"
  project     = "amir-251909"
  region      = "europe-north1"
  zone        = "europe-north1-a"

}