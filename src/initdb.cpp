#include "initdb.h"
#include <QDir>

InitDb::InitDb(QObject* parent) : QObject(parent)
{

    QString dbName = "immo.db"; // Database file name

    // Construct the absolute path to the database file
    QString dbPath = QDir::currentPath() + "/" + dbName;


    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(dbPath);

    if (!db.open()) {
        qDebug() << "Error: Couldn't open database";
        return;
    }
    else {
        qDebug() << "Database Found:" << db.databaseName();
    }

    
    QSqlQuery query;
    if (!query.exec("CREATE TABLE IF NOT EXISTS agents (id INTEGER PRIMARY KEY AUTOINCREMENT, host TEXT, label TEXT, tag TEXT, grpc_port INTEGER, grpc_username TEXT, grpc_password TEXT)")) {
        qDebug() << "Error creating agents table:" << query.lastError().text();
        return;
    }
}

void InitDb::initDb()
{
    QSqlQuery query;
    query.prepare("INSERT INTO agents (host, label, tag, grpc_port, grpc_username, grpc_password) "
        "VALUES (:host, :label, :tag, :grpc_port, :grpc_username, :grpc_password)");

    // Example data
    query.bindValue(":host", "localhost");
    query.bindValue(":label", "Agent 1");
    query.bindValue(":tag", "tag1");
    query.bindValue(":grpc_port", 50051);
    query.bindValue(":grpc_username", "user1");
    query.bindValue(":grpc_password", "pass1");

    if (query.exec())
    {
        qDebug() << "Database initialization Completed";
    }
    else
    {
        qDebug() << "addPerson error:" << query.lastError();
    }
}