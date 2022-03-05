import 'package:bloc_sample/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_sample/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_sample/model/todoModel.dart';
import 'package:bloc_sample/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_sample/blocks/todos/todos_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
  }) : super(
          key: key,
        );
  TextEditingController idController = TextEditingController();
  TextEditingController taskControler = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Todo? todo;
  @override
  Widget build(
    BuildContext context,
  ) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedoutState) {
            Navigator.popUntil(
              context,
              (route) => route.isFirst,
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: (() {
                showDialog(
                  context: context,
                  builder: (
                    BuildContext context,
                  ) {
                    return BlocListener<TodosBloc, TodosState>(
                      listener: (
                        context,
                        state,
                      ) {
                        if (state is TodosLoaded) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Todo Added Successfully",
                              ),
                            ),
                          );
                        }
                        // TODO: implement listener
                      },
                      child: AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: idController,
                              decoration: const InputDecoration(
                                hintText: "ID:",
                              ),
                            ),
                            TextFormField(
                              controller: taskControler,
                              decoration: const InputDecoration(
                                hintText: "Task:",
                              ),
                            ),
                            TextFormField(
                              controller: descriptionController,
                              decoration: const InputDecoration(
                                hintText: "Description:",
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.blue,
                                ),
                              ),
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                var todoData = Todo(
                                  id: idController.text,
                                  task: taskControler.text,
                                  description: descriptionController.text,
                                );
                                context
                                    .read<TodosBloc>()
                                    .add(AddTodo(todo: todoData));
                                Navigator.pop(context);
                                idController.clear();
                                taskControler.clear();
                                descriptionController.clear();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
              child: const Icon(
                Icons.add,
              ),
            ),
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).logout();
                    },
                    icon: const Icon(Icons.exit_to_app))
              ],
              centerTitle: true,
              title: const Text(
                "Todo Sample",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
            body: BlocBuilder<TodosBloc, TodosState>(
              builder: (context, state) {
                if (state is TodosLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is TodosLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: ListView.separated(
                      itemBuilder: (
                        BuildContext context,
                        index,
                      ) {
                        var data = state.todos[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              child: Text(data.id),
                            ),
                            Text(
                              data.task,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.pending_actions,
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                IconButton(
                                  onPressed: () {
                                    context.read<TodosBloc>().add(
                                          Delete(
                                            todo: data,
                                          ),
                                        );
                                  },
                                  icon: const Icon(
                                    Icons.cancel,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (
                        BuildContext context,
                        index,
                      ) {
                        return const SizedBox(
                          height: 14,
                        );
                      },
                      itemCount: state.todos.length,
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Something Went Wrong",
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
