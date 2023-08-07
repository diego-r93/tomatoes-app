import 'package:flutter_dotenv/flutter_dotenv.dart';

String? username = dotenv.get('MONGO_USERNAME');
String? password = dotenv.get('MONGO_PASSWORD');
String? clusterName = dotenv.get('MONGO_CLUSTER_NAME');
String? databaseName = dotenv.get('MONGO_DATABASE_NAME');
String? userCollection = dotenv.get('MONGO_USER_COLLECTION');

String mongoConnUrl =
    "mongodb+srv://$username:$password@$clusterName.mongodb.net/$databaseName?retryWrites=true&w=majority";
