#include "agentModel.h"
 
AgentModel::AgentModel(QObject *parent) : QSqlQueryModel(parent) 
{
    loadAgents();
}

QVariant AgentModel::data(const QModelIndex& index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if (role < Qt::UserRole)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

void AgentModel::loadAgents()
{
    QSqlQuery query;
    query.prepare(SQL_SELECT);

    if (!query.exec()) {
        qDebug() << "Error executing query:" << query.lastError().text();
        return;
    }

    // Clear any existing data in the model
    clear();

    // Populate the model with the fetched data
    setQuery(query);

    if (lastError().isValid()) {
        qDebug() << "Error loading agents:" << lastError().text();
    }
    else {
        qDebug() << "First Row Data:" << record(0); // Check the label field of the first row
        qDebug() << "Query Executed Successfully:" << query.isActive();
        qDebug() << "Number of Rows Retrieved:" << rowCount();
    }

    // Output the data of each row
    for (int i = 0; i < rowCount(); ++i) {
        qDebug() << "Row Data:" << record(i).value("host").toString()
            << record(i).value("label").toString()
            << record(i).value("tag").toString()
            << record(i).value("grpc_port").toInt()
            << record(i).value("grpc_username").toString()
            << record(i).value("grpc_password").toString();
    }
    qDebug() << "Agents Loaded Successfully";
}

QHash<int, QByteArray> AgentModel::roleNames() const
{
    QHash<int, QByteArray> roleNames;
    for (int i = 0; COLUMN_NAMES[i] != nullptr; ++i) {
        roleNames[Qt::UserRole + i + 1] = COLUMN_NAMES[i];
    }
    qDebug() << "RoleNames: " << roleNames;
    return roleNames;
}

const char* AgentModel::COLUMN_NAMES[] = {
    "host",
    "label",
    "tag",
    "grpc_port",
    "grpc_username",
    "grpc_password",
    nullptr // Null-terminated array
};

const char* AgentModel::SQL_SELECT = "SELECT host, label, tag, grpc_port, grpc_username, grpc_password FROM agents";