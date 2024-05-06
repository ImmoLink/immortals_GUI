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
        qDebug() << "Query Executed Successfully:" << query.isActive();
        qDebug() << "Number of Rows Retrieved:" << rowCount();
    }

    qDebug() << "Agents Loaded Successfully";
}

bool AgentModel::insertAgent(const QString& host, const QString& label, const QString& tag,
    int grpcPort, const QString& grpcUsername, const QString& grpcPassword) {
    QSqlQuery query;
    query.prepare(SQL_INSERT);
    query.bindValue(":host", host);
    query.bindValue(":label", label);
    query.bindValue(":tag", tag);
    query.bindValue(":grpcPort", grpcPort);
    query.bindValue(":grpcUsername", grpcUsername);
    query.bindValue(":grpcPassword", grpcPassword);

    if (!query.exec()) {
        qDebug() << "Error executing query:" << query.lastError().text();
        return false;
    }

    loadAgents();
    return true;
}

bool AgentModel::deleteAgent(int id) {
    qDebug() << "Deleting Agent ID: " << id;
    QSqlQuery query;
    query.prepare(SQL_DELETE);
    query.bindValue(":id", id);

    if (!query.exec()) {
        qDebug() << "Error executing query:" << query.lastError().text();
        return false;
    }

    loadAgents();
    return true;
}

bool AgentModel::updateAgent(int id, const QString& host, const QString& label, const QString& tag,
    int grpcPort, const QString& grpcUsername, const QString& grpcPassword) {
    QSqlQuery query;
    query.prepare(SQL_UPDATE);
    query.bindValue(":id", id);
    query.bindValue(":host", host);
    query.bindValue(":label", label);
    query.bindValue(":tag", tag);
    query.bindValue(":grpcPort", grpcPort);
    query.bindValue(":grpcUsername", grpcUsername);
    query.bindValue(":grpcPassword", grpcPassword);

    if (!query.exec()) {
        qDebug() << "Error executing query:" << query.lastError().text();
        return false;
    }

    loadAgents();
    return true;
}

QHash<int, QByteArray> AgentModel::roleNames() const
{
    QHash<int, QByteArray> roleNames;
    for (int i = 0; COLUMN_NAMES[i] != nullptr; ++i) {
        roleNames[Qt::UserRole + i + 1] = COLUMN_NAMES[i];
    }
    return roleNames;
}

const char* AgentModel::COLUMN_NAMES[] = {
    "id",
    "host",
    "label",
    "tag",
    "grpc_port",
    "grpc_username",
    "grpc_password",
    nullptr // Null-terminated array
};

const char* AgentModel::SQL_SELECT = "SELECT id, host, label, tag, grpc_port, grpc_username, grpc_password FROM agents";
const char* AgentModel::SQL_INSERT = "INSERT INTO agents (host, label, tag, grpc_port, grpc_username, grpc_password) "
"VALUES (:host, :label, :tag, :grpcPort, :grpcUsername, :grpcPassword)";
const char* AgentModel::SQL_DELETE = "DELETE FROM agents WHERE id=:id";
const char* AgentModel::SQL_UPDATE = "UPDATE agents SET host = :host, label = :label, tag = :tag,"
"grpc_port = :grpcPort, grpc_username = :grpcUsername, grpc_password = :grpcPassword WHERE id = :id";