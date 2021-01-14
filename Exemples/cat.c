int main (int argc, char **argv)
{
  int i, c;

  for (i=1; i<argc; i++)
    {
      int *f;
      int d;
      d = -1;
      f = fopen (argv[i], "r");
      while ((c = fgetc (f))!=(-1))
	      fputc (c, stdout);
      fclose (f);
    }
  fflush (stdout);
  exit (0);
}
