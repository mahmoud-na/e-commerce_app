import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  bool isBottomSheetShown = false;
  bool isDarkMode = false;
  List<BottomNavigationBarItem> bottomBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      label: "Tasks",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.check_circle_outline_rounded),
      label: "Done",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.archive_outlined),
      label: "Archived",
    ),
  ];



  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  void changeBottomSheetState({required bool isShow}) {
    isBottomSheetShown = isShow;
    emit(AppChangeBottomSheetState());
  }

/*
  * id Integer
  * title String
  * date String
  * time String
  * status String
*/

/*
    * Create Database
    * Create table
    * Open Database
    * Insert in database
    * Get From Database
    * Delete From Database
    * Update Database
*/

  createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database database, int version) async {
        print('Database Created Successfully');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('Table Created Successfully');
        }).catchError((error) {
          print('Error When Creating Table: ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('DataBase Opened Successfully');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then(
        (value) {
          print('Row => $value In Table Inserted Successfully');
          emit(AppInsertDatabaseState());
          getDataFromDatabase(database);
        },
      ).catchError((error) {
        print('Error When Inserting Table: ${error.toString()}');
      });
      return Future(() {});
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetLoadingDatabaseState());
    database.rawQuery('SELECT *FROM tasks').then((value) {
      value.forEach((element) {
        print(element['status']);
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else if (element['status'] == 'archived') {
          archivedTasks.add(element);
        }
      });
      // print(tasks);
      emit(AppGetDatabaseState());
    });
  }

  void updateDatabase({required String status, required int id}) {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      [status, id],
    ).then((value) {
      emit(AppUpdateDatabaseState());
      getDataFromDatabase(database);
    });
  }

  void deleteFromDatabase({required int id}) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      emit(AppDeleteFromDatabaseState());
      getDataFromDatabase(database);
    });
  }

  void changeAppThemeMode({dynamic fromShared}) {
    if (fromShared != null) {
      isDarkMode = fromShared;
      emit(AppChangeThemeModeState());
    } else {
      isDarkMode = !isDarkMode;
      CacheHelper.putBooleanData(key: 'isDark', value: isDarkMode)
          .then((value) {
        emit(AppChangeThemeModeState());
      });
    }
  }
}
