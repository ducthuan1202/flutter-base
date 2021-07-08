import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Ship extends StatelessWidget {
  const Ship({Key? key}) : super(key: key);

  final String launchesPast = """
    query launchesPast(\$limit: Int!){
      launchesPast(limit: \$limit) {
        mission_name 
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(launchesPast),
        variables: {
          'limit': 30,
        },
        pollInterval: Duration(seconds: 10),
      ),
      builder: (QueryResult result, {Refetch? refetch, FetchMore? fetchMore}) {

        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return Container(
            child: LinearProgressIndicator(),
          );
        }

        List data = result.data?['launchesPast'];

        return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => Text(data[index]['mission_name'])
        );
      },
    );
  }
}
