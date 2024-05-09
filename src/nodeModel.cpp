#include "nodeModel.h"

NodeModel::NodeModel(QObject* parent) : QSqlQueryModel(parent) {}

QVariant NodeModel::data(const QModelIndex& index, int role) const
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

void NodeModel::loadNodes(int agentID)
{
    QSqlQuery query;
    query.prepare(SQL_SELECT);
    query.bindValue(":agentID", agentID);

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

bool NodeModel::insertNode(const QString& name, int agentID, const QString& clientID) {
    QSqlQuery query;
    query.prepare(SQL_INSERT);
    query.bindValue(":name", name);
    query.bindValue(":agentID", agentID);
    query.bindValue(":clientID", clientID);

    if (!query.exec()) {
        qDebug() << "Error executing query:" << query.lastError().text();
        return false;
    }

    loadNodes(agentID);
    return true;
}

bool NodeModel::deleteNode(int id, int agentID) {
    qDebug() << "Deleting Agent ID: " << id;
    QSqlQuery query;
    query.prepare(SQL_DELETE);
    query.bindValue(":id", id);

    if (!query.exec()) {
        qDebug() << "Error executing query:" << query.lastError().text();
        return false;
    }

    loadNodes(agentID);
    return true;
}

bool NodeModel::updateNode(int id, int agentID, const QString& name) {
    QSqlQuery query;
    query.prepare(SQL_UPDATE);
    query.bindValue(":id", id);
    query.bindValue(":name", name);

    if (!query.exec()) {
        qDebug() << "Error executing query:" << query.lastError().text();
        return false;
    }

    loadNodes(agentID);
    return true;
}

QHash<int, QByteArray> NodeModel::roleNames() const
{
    QHash<int, QByteArray> roleNames;
    for (int i = 0; COLUMN_NAMES[i] != nullptr; ++i) {
        roleNames[Qt::UserRole + i + 1] = COLUMN_NAMES[i];
    }
    return roleNames;
}

const char* NodeModel::COLUMN_NAMES[] = {
    "id",
    "name",
    "agentID",
    "clientID",
    "is_online",
    nullptr // Null-terminated array
};

const char* NodeModel::SQL_SELECT = "SELECT id, name, agentID, clientID, is_online FROM nodes WHERE agentID = :agentID";
const char* NodeModel::SQL_INSERT = "INSERT INTO nodes (name, agentID, clientID) VALUES (:name, :agentID, :clientID)";
const char* NodeModel::SQL_DELETE = "DELETE FROM nodes WHERE id=:id";
const char* NodeModel::SQL_UPDATE = "UPDATE nodes SET name = :name WHERE id = :id";