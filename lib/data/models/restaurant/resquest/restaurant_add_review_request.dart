// URL: /review
// Method: POST
// Headers:
// Content-Type: application/json
// Body:
// JSON: {"id": string, "name": string, "review": string}

class AddReviewRequest {
  final String id;
  final String name;
  final String review;

  AddReviewRequest({
    required this.id,
    required this.name,
    required this.review,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'review': review};
  }
}
