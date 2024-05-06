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
};

#endif // INITDB_H