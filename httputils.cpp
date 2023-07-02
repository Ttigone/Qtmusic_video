#include "httputils.h"
#include <QDebug>
#include <QNetworkReply>

HttpUtils::HttpUtils(QObject *parent)
    : QObject{parent}
{
    manager = new QNetworkAccessManager(this);

    QObject::connect(manager, SIGNAL(finished(QNetworkReply *)), this, SLOT(replyFinished(QNetworkReply *)));

}

void HttpUtils::connet(QString url)
{
    QNetworkRequest request;
    request.setUrl(QUrl(BASE_URL + url));  // 设置请求地址
    manager->get(request);             // 获取请求
}

void HttpUtils::replyFinished(QNetworkReply *reply)
{
    emit replySignal(reply->readAll());
}

HttpUtils::~HttpUtils() {
    delete manager;
}
