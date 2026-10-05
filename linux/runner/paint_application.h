#ifndef FLUTTER_PAINT_APPLICATION_H_
#define FLUTTER_PAINT_APPLICATION_H_

#include <gtk/gtk.h>

G_DECLARE_FINAL_TYPE(PaintApplication,
                     paint_application,
                     PAINT,
                     APPLICATION,
                     GtkApplication)

/**
 * paint_application_new:
 *
 * Creates a new Flutter-based application.
 *
 * Returns: a new #PaintApplication.
 */
PaintApplication* paint_application_new();

#endif  // FLUTTER_PAINT_APPLICATION_H_
