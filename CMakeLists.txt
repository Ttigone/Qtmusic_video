cmake_minimum_required(VERSION 3.16)

project(Qtmusic_video VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.2 COMPONENTS Quick REQUIRED)

qt_add_executable(appQtmusic_video
    App.cpp httputils.cpp
)

qt_add_qml_module(appQtmusic_video
    URI Qtmusic_video
    VERSION 1.0
    QML_FILES App.qml
    LayoutHeaderView.qml LayoutBottonView.qml PageHomeView.qml
    MusicIconBotton.qml MusicToolBotton.qml MusicRoundImage.qml
    DetailRecommendPageView.qml
    DetailSearchPageView.qml
    DetailLocalPageView.qml
    DetailHistoryPageView.qml
    DetailFavoritePageView.qml
    MusicBannerView.qml
    MusicGridHotView.qml
    MusicGridLatestView.qml
    MusicListView.qml
    DetailPlayListPageView.qml
)

set(resources_files resources.qrc)
qt6_add_resources(sources ${resources_files})

target_sources(appQtmusic_video PRIVATE ${sources})


set_target_properties(appQtmusic_video PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appQtmusic_video
    PRIVATE Qt6::Quick)

install(TARGETS appQtmusic_video
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
