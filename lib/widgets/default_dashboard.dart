import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:goodwork/models/task.dart';
import 'package:intl/intl.dart';

class DefaultDashboard extends StatefulWidget {
  const DefaultDashboard({this.currentWork});

  final List<Task> currentWork;

  @override
  _DefaultDashboardState createState() => _DefaultDashboardState();
}

class _DefaultDashboardState extends State<DefaultDashboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(60, 66, 87, .12),
            blurRadius: 14.0,
            offset: Offset(0.0, 7.0),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, .12),
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'What\'s on your plate today ⬇️',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: Colors.blue,
              ),
            ),
            child: ConditionalBuilder(
              condition: widget.currentWork != null,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text('Due On: '),
                          Container(
                            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              color: Colors.teal[100],
                            ),
                            child: Text(
                              DateFormat('MMM d').format(
                                DateTime.parse(widget.currentWork[0].dueOn),
                              ),
                              style: TextStyle(
                                color: Colors.teal[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.currentWork[0].name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Divider(
                        height: 10,
                        thickness: 2,
                        color: Colors.grey[300],
                      ),
                      const Text(
                        'No progress update yet',
                      ),
                    ],
                  ),
                );
              },
              fallback: (BuildContext context) {
                return const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                      'There is currently no work \'In Progress\' assigned to you'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
