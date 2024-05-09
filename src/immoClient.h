#ifndef IMMOCLIENT_H
#define IMMOCLIENT_H

#include <qobject.h>
#include <qstring.h>

class ImmoClient : public QObject
{
	Q_OBJECT
public:
	explicit ImmoClient(QObject* parent = nullptr);
	Q_INVOKABLE QString discoverNode(const QString& name, const QString& address);
};

#endif