/*
model key customerReviews
model ini dipakai pada api: Add Review
"customerReviews": [
  {
    "name": "Ahmad",
    "review": "Tidak rekomendasi untuk pelajar!",
    "date": "13 November 2019"
  },
  {
    "name": "test",
    "review": "makanannya lezat",
    "date": "29 Oktober 2020"
  }
]
 */

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "review": review,
    "date": date,
  };
}
