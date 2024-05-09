#ifndef NODEMODEL_H
#define NODEMODEL_H

#include <QSqlQueryModel>
#include <QObject>
#include <QtSql>

// Define a class for the model
class NodeModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    explicit NodeModel(QObject* parent = nullptr);

    // Function to load agents from the database
    Q_INVOKABLE void loadNodes(int agentID);
    Q_INVOKABLE bool insertNode(const QString& name, int agentID, const QString& clientID);
    Q_INVOKABLE bool updateNode(int id, int agentID, const QString& name);
    Q_INVOKABLE bool deleteNode(int id, int agentID);

    QHash<int, QByteArray> roleNames() const;
    QVariant data(const QModelIndex& index, int role) const;

signals:

public slots:

private:
    const static char* COLUMN_NAMES[];
    const static char* SQL_SELECT;
    const static char* SQL_INSERT;
    const static char* SQL_DELETE;
    const static char* SQL_UPDATE;
};

#endif