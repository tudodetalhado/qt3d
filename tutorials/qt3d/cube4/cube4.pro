TEMPLATE = app
TARGET = cube4
CONFIG += qt warn_on
QT += qt3d
SOURCES = cubeview.cpp main.cpp
HEADERS = cubeview.h
RESOURCES = cube.qrc
DESTDIR = $$QT.qt3d.bins/qt3d/tutorials
