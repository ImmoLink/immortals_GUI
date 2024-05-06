#ifndef AGENTMODEL_H
#define AGENTMODEL_H

#include <QSqlQueryModel>
#include <QObject>
#include <QtSql>

// Define a class for the model
class AgentModel : public QSqlQueryModel
{
    Q_OBJECT

public:
    explicit AgentModel(QObject *parent=nullptr);

    // Function to load agents from the database
    Q_INVOKABLE void loadAgents();
    Q_INVOKABLE bool insertAgent(const QString& host, const QString& label, const QString& tag, int grpcPort, const QString& grpcUsername, const QString& grpcPassword);
    Q_INVOKABLE bool updateAgent(int id, const QString& host, const QString& label, const QString& tag, int grpcPort, const QString& grpcUsername, const QString& grpcPassword);
    Q_INVOKABLE bool deleteAgent(int id);

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