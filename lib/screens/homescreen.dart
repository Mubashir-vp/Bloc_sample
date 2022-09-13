import 'package:bloc_sample/cubits/auth_cubit/auth_cubit.dart';
import 'package:bloc_sample/cubits/auth_cubit/auth_state.dart';
import 'package:bloc_sample/homescreen.dart';
import 'package:bloc_sample/model/todoModel.dart';
import 'package:bloc_sample/new_blocks/firebaseBloc/dbbloc_bloc.dart';
import 'package:bloc_sample/screens/apiScreen.dart';
import 'package:bloc_sample/screens/loginScreen.dart';
import 'package:bloc_sample/screens/loginSelectionScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                builder: (context) => const LoginSelectionScreen(),
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
                    return BlocListener<DbblocBloc, DbblocState>(
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
                                    .read<DbblocBloc>()
                                    .add(AddTodo(todos: todoData));
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
              leading: IconButton(
                onPressed: () {
Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  ApiScreen(),
              ),
            );                },
                icon: const Icon(
                  Icons.api_outlined,
                ),
              ),
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
            body: BlocBuilder<DbblocBloc, DbblocState>(
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
                        return ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              taskControler.text = data.task;
                              descriptionController.text = data.description;
                              showDialog(
                                context: context,
                                builder: (
                                  BuildContext context,
                                ) {
                                  return BlocListener<DbblocBloc, DbblocState>(
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
                                            readOnly: true,
                                            initialValue: data.id,
                                            decoration: const InputDecoration(),
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
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                Colors.blue,
                                              ),
                                            ),
                                            child: const Text(
                                              "Update",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () {
                                              var todoData = Todo(
                                                id: data.id,
                                                task: taskControler.text,
                                                description:
                                                    descriptionController.text,
                                              );
                                              context.read<DbblocBloc>().add(
                                                  UpdateTodo(todos: todoData));
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
                            },
                            child: CircleAvatar(
                              child: Text(data.id),
                            ),
                          ),
                          title: Text(
                            data.task,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              context.read<DbblocBloc>().add(
                                    DeleteTodo(
                                      todos: data,
                                    ),
                                  );
                            },
                            child: const Icon(
                              Icons.delete,
                            ),
                          ),
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
                } else if (state is EmptyTodos) {
                  return const Center(
                    child: Text(
                      "Currently There are no Todos",
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
