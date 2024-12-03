﻿using System.ComponentModel;
using System.Windows;
using System.Windows.Media;
using System.Windows.Shapes;

namespace WPF_Formen
{
    internal class Basis : Shape
    {
        #region Overrides
        protected override Geometry DefiningGeometry
        {
            get
            {
                PathGeometry geometry = new()
                {
                    FillRule = FillRule.EvenOdd
                };
                geometry.Figures.Add(CreatePathFigure());
                return geometry;

            }
        }
        #endregion

        public static readonly DependencyProperty X1Property = DependencyProperty.Register("X1", typeof(Double), typeof(Basis), new FrameworkPropertyMetadata(0.0, FrameworkPropertyMetadataOptions.AffectsRender | FrameworkPropertyMetadataOptions.AffectsMeasure));
        public static readonly DependencyProperty Y1Property = DependencyProperty.Register("Y1", typeof(Double), typeof(Basis), new FrameworkPropertyMetadata(0.0, FrameworkPropertyMetadataOptions.AffectsRender | FrameworkPropertyMetadataOptions.AffectsMeasure));

        [TypeConverter(typeof(LengthConverter))]
        public double X1
        {
            get => (double)GetValue(X1Property);
            set => SetValue(X1Property, value);
        }

        [TypeConverter(typeof(LengthConverter))]
        public double Y1
        {
            get => (double)GetValue(Y1Property);
            set => SetValue(Y1Property, value);
        }

        /// <summary>
        /// Zeichnet einen Punkt
        /// </summary>
        protected virtual PathFigure CreatePathFigure()
        {
            PathFigure myPathFigure = new()
            {
                StartPoint = new Point(X1 - 10, Y1),
                IsClosed = false
            };
            myPathFigure.Segments.Add(new LineSegment(new Point(X1 + 10, Y1), true));
            myPathFigure.Segments.Add(new LineSegment(new Point(X1, Y1 - 10), false));
            myPathFigure.Segments.Add(new LineSegment(new Point(X1, Y1 + 10), true));
            return myPathFigure;
        }
    }
}
