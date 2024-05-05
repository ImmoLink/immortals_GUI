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
    void loadAgents();
    QHash<int, QByteArray> roleNames() const;
    QVariant data(const QModelIndex& index, int role) const;

signals:

public slots:

private:
    const static char* COLUMN_NAMES[];
    const static char* SQL_SELECT;
};

#endif