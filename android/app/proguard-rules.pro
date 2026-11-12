# Android Gradle Plugin 9 uses stricter full-mode R8 keep-rule semantics.
# WorkManager 2.7.1 / Room 2.2.5 instantiate this generated Room database
# implementation reflectively, so keep its no-argument constructor and members.
-keep class androidx.work.impl.WorkDatabase { *; }
-keep class androidx.work.impl.WorkDatabase_Impl { *; }
