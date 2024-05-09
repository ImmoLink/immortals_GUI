#ifndef INITDB_H
#define INITDB_H

#include <QObject>
#include <QtSql>

class InitDb : public QObject
{
    Q_OBJECT
public:
    explicit InitDb(QObject* parent = nullptr);

public slots:
    void initDb();

private:
    const static char* SQL_AGENTS_TABLE;
    const static char* SQL_INSERT_AGENT;
    const static char* SQL_NODES_TABLE;
    const static char* SQL_INSERT_NODE;
};

#endif // INITDB_H